#!/usr/bin/perl

use strict;
use DBI;
use Socket6;
use Math::Int64 qw(int64 uint64 hex_to_uint64);
use Data::Dumper;
use JSON;
use POSIX ':sys_wait_h';
use Time::HiRes qw(gettimeofday tv_interval);
use File::Temp qw(tempfile);
use Fcntl qw(:flock SEEK_END);
use File::Basename;

$|=1;

my($file) = @ARGV;

$file = dirname($0) . '/../etc/config.json' if !defined $file;

if ( ! -r $file ) {
	print STDERR "Usage: $0 <config file>\n";
	exit 1;
}

my $conf = load_conf($file);

if ( !defined $conf ) {
	print STDERR "Failed to load configuration file '$file'\n";
	exit 1;
}

$conf->{lockfile} = tempfile();

my $dbh = sqlconnect($conf->{sql});

my $peers = { };

my $global_stop = 0;

$SIG{'INT'} = sub { $global_stop=1; };

while(!$global_stop) {
	# get the current peer list
	my $new = get_peer_list($dbh);

	# merge the two lists,
	# kill gone peers and add the new ones
	# return 1 if anything changed in the peers
	if ( unify_peer_list($peers,$new) ) {
			peer_log(undef, "Peer list changed\n");
			foreach my $id ( sort keys %{$peers} ) {
				my $p = $peers->{$id};
				peer_log($p, "setting peer tables");
				sqlquery($dbh,"CALL manage_peer(?,'create')", $p->{id});
			}
			peer_log(undef, "ready");
	}

	# did anyone die or needs start?
	foreach my $id ( sort keys %{$peers} ) {
		my $p = $peers->{$id};

		if ( exists $p->{pid} && waitpid($p->{pid}, WNOHANG) > 0 ) {
			peer_log($p, "Worker end");
			delete $p->{pid};
		}

		if ( !exists $p->{pid} ) {

			$p->{pid} = fork();

			if ( $p->{pid} > 0 ) {
				peer_log($p, "Worker start");
			}
			else {
				$p->{pid} = $$;
				$dbh = undef;
				handle_peer($conf,$p);
				exit;
			}
		}
	}

	#print Dumper($peers);
	sleep 5;
}

print "Interrupted by USER\n";

# count the childs
my $childs = 0;
foreach my $id ( keys %{$peers} ) {
	$childs++ if exists $peers->{$id}{pid};
}

while($childs) {
	print "Waiting for $childs to terminate\n";
	wait();
	$childs--;
}

print "Terminating\n";


sub handle_peer {
	my($conf, $peer) = @_;

	my $oname = "piranha_injector id=$peer->{id} ip=$peer->{ip} as=$peer->{asn} status=";

	$0 = $oname . 'init';

	my $dbh = sqlconnect($conf->{sql});
	my $queue;


	while(!$global_stop) {
		$0 = $oname . 'list_queue';
		$queue = get_peer_queue($peer);

		if ( scalar(@{$queue}) ) {
			for(my $i=0; $i<scalar(@{$queue}); $i++) {
				$0 = $oname . 'working (' . ($i+1) . '/' . (scalar(@{$queue})) . ')';
				peer_log($peer, "processing file ".($i+1)."/".(scalar(@{$queue}))." : ".$queue->[$i]);
				handle_file($conf, $peer, $dbh, $queue->[$i]);
				last if $global_stop;
			}
		}
		else {
			$0 = $oname . 'waiting';
			sleep 5;
		}
	}
}

sub handle_file {
	my($conf, $peer, $dbh, $file) = @_;

	my $time_start = [gettimeofday];
	my %stats;
	my %dbstats;
	my $msgcnt=0;

	my %msgtype = (
		'P' => 'peer',
		'A' => 'announce',
		'W' => 'withdrawn',
		'E' => 'eof',
		'C' => 'connect',
		'D' => 'disconnect',
		'K' => 'keepalive',
	);

	my %jmsg = (
		'peer'       => 'P',
		'announce'   => 'A',
		'withdrawn'  => 'W',
		'footer'     => 'E',
		'connect'    => 'C',
		'disconnect' => 'D',
		'keepalive'  => 'K',
	);

	my $ibgp = 0;

	my @queue;
	my $lasttype;

	sub flush_queue {
		my ($q) = @_;

		return if ! scalar(@{$q});

		for(my $f=0; $f<$conf->{burst_childs_per_peer}; $f++) {
			next if fork();
			$0 .= " worker $f";
			my $newdbh = sqlconnect($conf->{sql});
			for(my $i=$f; defined ${$q}[$i]; $i+=$conf->{burst_childs_per_peer}) {
				sqlquery($newdbh, @{${$q}[$i]});
			}
			exit;
		}

		for(my $f=0; $f<$conf->{burst_childs_per_peer}; $f++) {
			wait();
		}
	}

	open(P,"$conf->{piranha}/bin/ptoa -j $file |");
	while(<P>) {
		my $e = from_json($_);

		$msgcnt++;

		$stats{$e->{type}}++;

		my $statstime = int($e->{timestamp}) - ( int($e->{timestamp}) % 60 );
		$dbstats{$statstime}{$jmsg{$e->{type}}}++;

		if (
			defined $lasttype &&
			( $lasttype ne $e->{type} || scalar(@queue) >= $conf->{max_burst_queue_per_child} * $conf->{burst_childs_per_peer} ) &&
		       	( $lasttype eq 'announce' || $lasttype eq 'withdrawn' ) ) {

			peer_log($peer,"queue flush: " . (scalar(@queue)));

			flush_queue(\@queue);
			@queue = ( );
		}

		if ( $e->{type} eq 'peer' ) {
			$ibgp=$e->{msg}{peer}{asn} if $e->{msg}{peer}{type} eq 'ibgp';
			peer_log($peer, "peer file begin");
		}
		elsif ( $e->{type} eq 'connect' ) {
			peer_log($peer, "peer connected");
			sqlquery($dbh,"CALL manage_peer(?,'reset')", $peer->{id});
			sqlquery($dbh,"UPDATE peer SET state = 1, lastup = FROM_UNIXTIME(?) WHERE id = ?", $e->{timestamp}, $peer->{id});
		}
		elsif ( $e->{type} eq 'disconnect' ) {
			peer_log($peer, "peer disconnected");
			sqlquery($dbh,"UPDATE peer SET state = 0, lastdown = FROM_UNIXTIME(?) WHERE id = ?", $e->{timestamp}, $peer->{id});
		}
		elsif ( $e->{type} eq 'announce' ) {

			my $origin_as    = 0;
			my $aspathhex    = undef;
			my $communityhex = undef;

			# distinguish iBGP and eBGP and prefix the path with the
			# neighbor AS if iBGP. This is needed for consistency
			# in aspath storage
			if ( $ibgp>0 ) {
				$e->{msg}{aspath} = [ ] if !exists $e->{msg}{aspath};
				unshift @{$e->{msg}{aspath}}, $peer->{asn};
			}

			if ( exists $e->{msg}{aspath} ) {
				$origin_as = ${$e->{msg}{aspath}}[-1];
				$aspathhex = '';
				foreach my $asn ( @{$e->{msg}{aspath}} ) {
					$aspathhex .= sprintf("%08x", $asn);
				}
			}

			if ( exists $e->{msg}{community} ) {
				$communityhex = '';
				foreach my $c ( @{$e->{msg}{community}} ) {
					$communityhex .= sprintf("%04x%04x", split(/:/,$c));
				}
			}

			push @queue, [ "CALL route_announce(?,?,?,?,?,?,?,\@err)",
				$peer->{id}, $e->{timestamp}, $e->{msg}{prefix}, $e->{msg}{nexthop},
				$origin_as, $aspathhex, $communityhex ];

			#sqlquery($dbh, 'CALL route_announce(?,?,?,?,?,?,?,@err)',
			#	$peer->{id}, $e->{timestamp}, $e->{msg}{prefix}, $e->{msg}{nexthop},
			#	$origin_as, $aspathhex, $communityhex);
			#
			#my $q = sqlquery($dbh, 'SELECT @err');
			#while(my $e = $q->fetchrow_hashref()) {
			#	peer_log($peer, "error for announce msg: $e->{error}") if exists $e->{error};
			#}
				
		}
		elsif ( $e->{type} eq 'withdrawn' ) {

			push @queue, [ "CALL route_withdrawn(?,?,?,\@err)", $peer->{id}, $e->{timestamp}, $e->{msg}{prefix} ];

			#sqlquery($dbh, 'CALL route_withdrawn(?,?,?,@err)',
			#	$peer->{id}, $e->{timestamp}, $e->{msg}{prefix});

			#my $q = sqlquery($dbh, 'SELECT @err');
			#while(my $e = $q->fetchrow_hashref()) {
			#	peer_log($peer, "error for withdrawn msg: $e->{error}") if exists $e->{error};
			#}
		}
		elsif ( $e->{type} eq 'footer' ) {
			peer_log($peer, "peer file end");
			sqlquery($dbh, 'UPDATE peer SET lastupdate = FROM_UNIXTIME(?) WHERE id = ?',
				$e->{timestamp}, $peer->{id});
		}

		# update the peer lastupdate only every 10000 msg to
		# avoid overloading the DB
		if ( ! ( $msgcnt % 10000 ) ) {
			sqlquery($dbh, 'UPDATE peer SET lastupdate = FROM_UNIXTIME(?) WHERE id = ?',
				$e->{timestamp}, $peer->{id});
		}

		$lasttype = $e->{type};

	}
	close(P);

	foreach my $ts ( keys %dbstats ) {
		foreach my $msg ( keys %{$dbstats{$ts}} ) {
			sqlquery($dbh,"
				INSERT INTO stats
				SET peerid = ?, ts = FROM_UNIXTIME(?), name = ?, value = ?
				ON DUPLICATE KEY UPDATE value  = value + ?",
				$peer->{id}, $ts, $msg, $dbstats{$ts}{$msg}, $dbstats{$ts}{$msg} );
		}
	}

	unlink($file);

	my $sum=0;
	foreach ( sort keys %stats ) {
		$sum+=$stats{$_};
		peer_log($peer, "stats: ".($_)." ".($stats{$_}));
	}
	my $elapsed = tv_interval($time_start, [gettimeofday]);
	peer_log($peer, sprintf("processing time: %0.3fs, %0.0fmsg/s", $elapsed, $sum/$elapsed));
}

sub sqlconnect {
	my ($sql) = @_;

	my $dbh = DBI->connect(
		"DBI:mysql:database=$sql->{base};host=$sql->{host}",
		$sql->{user}, $sql->{pass}, { AutoInactiveDestroy=>1 }
	) || die "Could not connect to database: $DBI::errstr";

	return $dbh;
}

sub sqlquery {
	my $dbh   = shift;
	my $query = shift;
	my @args  = @_;

	#print "DBH: $dbh\n";
	#print "QUERY: $query\n";
	#print Dumper(\@args);

	my $sth = $dbh->prepare($query);
	$sth->execute(@args) || print Dumper($query, \@args);

	return $sth;
}

sub load_conf {
		my($file) = @_;
		my $x = '';

		return undef if !defined $file;
		return undef if !-r $file;

		open(F,$file);
		while(<F>) { $x.=$_; }
		close(F);

		return from_json($x);

}

sub get_peer_list {
	my($dbh) = @_;

	my %r;

	my $q = sqlquery($dbh,"
			SELECT
				id,
				asn,
				inet_ntoa(ip4) AS ip4,
				ip6,
				IF(ip4 IS NULL, ip6, inet_ntoa(ip4)) AS ip
			FROM peer");
	while(my $x = $q->fetchrow_hashref()) {
		$r{$x->{id}} = $x;
	}

	return \%r;

}

sub get_peer_queue {
	my($p) = @_;

	my @q;

	my $path = $conf->{piranha} . '/var/dump/' . $p->{ip};
	if ( -d $path ) {
		opendir(DIR, $path);
		while(readdir(DIR)) { push @q, $path.'/'.$_ if /^\d+$/; }
		closedir(DIR);
	}
	my @s = sort(@q);
	return \@s;
}

sub unify_peer_list {
	my($cur,$new) = @_;

	my $all = { };

	my $changed = 0;

	$all->{$_}=1 foreach keys %{$cur};
	$all->{$_}=1 foreach keys %{$new};

	foreach my $id ( keys %{$all} ) {
		if ( !exists $cur->{$id} && exists $new->{$id} ) {
			peer_log($new->{$id}, "Peer has been added");
			$cur->{$id} = $new->{$id};
			$changed=1;
		}
		elsif ( exists $cur->{$id} && !exists $new->{$id} ) {
			peer_log($cur->{$id}, "Peer has been deconfigured, killing");
			kill 9, $cur->{$id}{pid} if exists $cur->{$id}{pid};
			delete $cur->{$id};
			$changed=1;
		}
	}
	return $changed;
}

sub peer_log {
	my($p,$msg) = @_;

	my($s,$us) = gettimeofday;

	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($s);

	printf("%04i-%02i-%02i %02i:%02i:%02i.%03i [peer_%i pid %s]: %s\n",
		$year+1900, $mon+1, $mday, $hour, $min, $sec, int($us/1000),
		defined $p ? $p->{id} : 0, $$, $msg);
}
