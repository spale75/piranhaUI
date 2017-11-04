#!/usr/bin/perl

use strict;
use DBI;
use Socket6;
use Data::Dumper;
use JSON;
use CGI::Fast qw(:standard);
use Time::HiRes qw(gettimeofday tv_interval);

my %conf = (
	peer_query => "
		SELECT
			id,
			inet_ntoa(ip4) AS ip4,
			ip6,
			IF(ip4 IS NULL,ip6,inet_ntoa(ip4)) AS ip,
			asn,
			lastupdate,
			easytime(UNIX_TIMESTAMP(CURRENT_TIMESTAMP(3)) - UNIX_TIMESTAMP(lastupdate)) AS deltanow,
			state,
			IF(state=1,'Up','Down') AS statename,
			IF(password IS NULL, 'No', 'Yes') AS password,
			descr,
			lastup,
			lastdown
		FROM peer",
	mtree => {
		'stats' => {
			func => \&mode_stats,
		},
		'peerlist' => {
			func => \&mode_peerlist,
		},
		'peer' => {
			func => \&mode_peer,
			dep => [ 'peerid' ],
		},
		'peer_last' => {
			func => \&mode_peer_last,
			dep => [ 'peerid', 'pagesize', 'page' ],
		},
		'graph' => {
			func => \&mode_graph,
			dep => [ 'peerid', 'modulo' ],
		},
		'rdap' => {
			func => \&mode_rdap,
			dep  => [ 'rdaptype', 'rdapdata' ],
		},
		'config' => {
			func => \&mode_config,
			dep  => [ 'action' ],
		},
		'top100' => {
			func => \&mode_top100,
			dep  => [ 'peerid', 'list', 'valid', 'invalid', 'proto', 'pagesize', 'page' ],
		},
		'search_prefix' => {
			func => \&mode_search_prefix,
			dep  => [ 'peerid', 'pagesize' ,'page', 'prefix', 'valid', 'invalid' ],
		},
		'search_originas' => {
			func => \&mode_search_originas,
			dep  => [ 'asn', 'proto', 'peerid', 'page', 'pagesize', 'valid', 'invalid' ],
		},
		'vis_bgp_updates' => {
			func => \&mode_vis_bgp_updates,
			dep  => [ 'proto' ],
		},
		'vis_border_paths' => {
			func => \&mode_vis_border_paths,
			dep => [ 'limit' ],
		},
	},
	
	vars => {
		peerid => '^\d+$',
		modulo => '^\d+$',
		action => '^(get|set)$',
		asn    => '^\d+$',
		list   => '^(flaps|long_aspath|invalid_asn)$',
		valid  => '^(true|false)$',
		invalid=> '^(true|false)$',
		proto  => '^[46]$',
		pagesize => '^\d+$',
		page     => '^\d+$',
		prefix   => '^[0-9a-fA-F:\.\/\-]*$',
		rdaptype => '^(asn|ip4|ip6)$',
		rdapdata => '^(\d+|\d+\.\d+\.\d+\.\d+(/\d+)?|[0-9a-fA-F:]+(/\d+)?)$',
		limit    => '^\d+$',
	},
	logfile => './cgi_sql.log',

);

$conf{conf} = load_conf("../etc/config.json");

my $dbh = sqlconnect($conf{conf}{sql});

while(new CGI::Fast) {

	if ( ! $dbh->ping ) {
		sqldisconnect($dbh);
		$dbh = sqlconnect($conf{conf}{sql});
	}

	my %var;
	foreach (split(/&/, $ENV{QUERY_STRING})) {
		my ($n,$v) = split(/=/);
		$n =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$v =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		if ( $n eq 'mode' || ( exists $conf{vars}{$n} && $v =~ /$conf{vars}{$n}/ ) ) {
			$var{$n}=$v;
		}
	}

	if ( exists $var{mode} && defined $var{mode} && exists $conf{mtree}{$var{mode}} ) {
		my %fvar;
		if ( exists $conf{mtree}{$var{mode}}{dep} ) {
			foreach my $req ( @{$conf{mtree}{$var{mode}}{dep}} ) {
				if ( !exists $var{$req} || !defined $var{$req} ) {
					json_error("required field ($req) for mode ($var{mode}) is missing");
				}
				$fvar{$req} = $var{$req};
			}
		}
		if ( exists $conf{mtree}{$var{mode}}{func} ) {
			json_output($conf{mtree}{$var{mode}}{func}($dbh, \%fvar));
		}
		else {
			json_error("mode $var{mode} has no defined function");
		}
	}
	else {
		json_error("mode missing or undefined");
	}
}

sub json_error {
	my($err) = @_;
	my %j = ( 'error' => $err );
	print "Content-type: application/json; charset=utf-8\r\n\r\n";
	print to_json(\%j, { utf8=>1, pretty=>1});
	exit;
}

sub json_output {
	my($j) = @_;
	if ( defined $j ) {
		print "Content-type: application/json; charset=utf-8\r\n\r\n";
		print to_json($j, { utf8=>1, pretty=>1});
	}
	else {
		json_error("function error, returned nothing");
	}
}


sub mode_stats {
	my ($dbh, $var) = @_;

	my ($v,$i);
	my $j = { };

	$v = sqlone($dbh,"SELECT COUNT(valid) as cnt FROM route4 WHERE valid=1");
	$i = sqlone($dbh,"SELECT COUNT(valid) as cnt FROM route4 WHERE valid=0");

	$j->{global}{ipv4}{valid}   = exists $v->{cnt} ? $v->{cnt} : 0;
	$j->{global}{ipv4}{invalid} = exists $i->{cnt} ? $i->{cnt} : 0;

	$v = sqlone($dbh,"SELECT COUNT(valid) as cnt FROM route6 WHERE valid=1");
	$i = sqlone($dbh,"SELECT COUNT(valid) as cnt FROM route6 WHERE valid=0");

	$j->{global}{ipv6}{valid}   = exists $v->{cnt} ? $v->{cnt} : 0;
	$j->{global}{ipv6}{invalid} = exists $i->{cnt} ? $i->{cnt} : 0;

	my $q = sqlquery($dbh,"SELECT COUNT(valid) AS cnt, netmask FROM route4 WHERE valid=1 GROUP BY netmask");
	while(my $m = $q->fetchrow_hashref()) { $j->{global}{ipv4}{mask}{$m->{netmask}}=$m->{cnt}; }

	$q = sqlquery($dbh,"SELECT COUNT(valid) AS cnt, netmask FROM route6 WHERE valid=1 GROUP BY netmask");
	while(my $m = $q->fetchrow_hashref()) { $j->{global}{ipv6}{mask}{$m->{netmask}}=$m->{cnt}; }

	$q = sqlquery($dbh,$conf{peer_query} . " ORDER BY id");
	while(my $p = $q->fetchrow_hashref()) {
		push @{$j->{peer}}, $p;
	}
	return $j;
}

sub mode_peerlist {
	my ($dbh, $var) = @_;
	my $j = { peer => [ ] };

	my $q = sqlquery($dbh,$conf{peer_query} . " ORDER BY id");
	while(my $p = $q->fetchrow_hashref()) {
		my $cnt = 0;
		my $q2 = sqlquery($dbh, "SELECT COUNT(valid) AS routes FROM peer_route_$p->{id} WHERE valid=1");
		while(my @c = $q2->fetchrow_array()) { $cnt = $c[0]; }
		$p->{routes} = $cnt;
		push @{$j->{peer}}, $p;
	}
	return $j;
}

sub mode_peer {
	my ($dbh, $var) = @_;
	my $j = { peer => { } };

	my $q = sqlquery($dbh,$conf{peer_query}." WHERE id = ?", $var->{peerid});
	while(my $p = $q->fetchrow_hashref()) {
		my $tbl = 'peer_route_' . $p->{id};

		my $x = sqlone($dbh,"SHOW TABLES LIKE ?", $tbl);

		if ( keys %{$x} ) {

			my $valid   = sqlone($dbh,"SELECT COUNT(valid) AS cnt FROM $tbl WHERE valid=1");
			my $invalid = sqlone($dbh,"SELECT COUNT(valid) AS cnt FROM $tbl WHERE valid=0");

			my $q2 = sqlquery($dbh,"SELECT COUNT(valid) AS cnt, netmask FROM $tbl WHERE valid=1 GROUP BY netmask");
			while(my $m = $q2->fetchrow_hashref()) { $p->{mask}{$m->{netmask}}=$m->{cnt}; }

			$p->{route}{valid}   = exists $valid->{cnt}   ? $valid->{cnt}   : 0;
			$p->{route}{invalid} = exists $invalid->{cnt} ? $invalid->{cnt} : 0;
		}
		$j->{peer} = $p;
	}
	return $j;
}

sub mode_peer_last {
	my ($dbh, $var) = @_;
	my $j = { route => [ ] };

	my $q = sqlquery($dbh,$conf{peer_query}." WHERE id = ?", $var->{peerid});
	while(my $p = $q->fetchrow_hashref()) {

		my $buf = 'peer_rbuf_'  . $p->{id};

		my $prefix = "CONCAT(inet_ntoa(network),'/',netmask) AS prefix";

		if ( defined $p->{ip6} ) {
			$prefix = "CONCAT(inet6_from2int(network1, network2),'/',netmask) AS prefix";
		}

		my $q2 = sqlquery($dbh, "
			SELECT
				NULL AS peer_ip,
				NULL AS peer_asn,
				$prefix,
				show_aspath(a.aslen,
					a.aspath1, a.aspath2, a.aspath3, a.aspath4,
					a.aspath5, a.aspath6, a.aspath7, a.aspath8, ?) AS aspath,
				show_community(c.comlen,
					c.community1, c.community2, c.community3, c.community4,
					c.community5, c.community6, c.community7, c.community8) AS community,
				n.nexthop AS nexthop,
				IF(msg='A',1,0) AS valid,
				timestamp AS updated,
				NULL AS flap_a,
				NULL AS flap_w
			FROM
				$buf AS b
					LEFT JOIN aspath a ON a.id = b.aspathid
					LEFT JOIN community c ON c.id = b.communityid
					LEFT JOIN nexthop n ON n.id = b.nexthopid
			ORDER BY
				timestamp DESC, pos
			LIMIT ?,?", $p->{asn}, $var->{page} * $var->{pagesize}, $var->{pagesize} );
		while(my $r = $q2->fetchrow_hashref()) {
			push @{$j->{route}}, $r;
		}
	}

	return $j;
}

sub mode_config {
	my ($dbh, $var) = @_;
	my $j = { conf => { } };

	if ( $var->{action} eq 'get' ) {
		my $q = sqlquery($dbh,"SELECT * FROM config");
		while(my $x = $q->fetchrow_hashref()) {
			$j->{conf}{$x->{name}} = $x->{value};
		}
	}
	elsif ( $var->{action} eq 'set' ) {
	}

	return $j;
}

sub mode_graph {
	my ($dbh, $var) = @_;
	my $j = { };

	$j->{id} = $var->{peerid};
	$j->{data} = [ ];
	$j->{event} = [ ];

	my $d = { };
	my $q = sqlquery($dbh, "CALL get_status(?, ?, ?)", $var->{peerid}, $var->{modulo}, 180);
	while(my $r = $q->fetchrow_hashref()) {

		if ( $r->{name} =~ /[AW]/ ) {
			if ( !exists $d->{$r->{ts}} ) {
				$d->{$r->{ts}} = { A => '0', W => '0', };
			}
			$d->{$r->{ts}}{$r->{name}} = $r->{value};
		}
	}

	$q = sqlquery($dbh, "
		SELECT ts, name
		FROM stats
		WHERE peerid = ?
		AND name IN ('C','D')
		ORDER BY ts DESC
		LIMIT 20", $var->{peerid});
	while(my $r = $q->fetchrow_hashref()) {
		$r->{ts} =~ s/:\d\d$//;
		push @{$j->{event}}, { "timestamp" => $r->{ts}, "type" => "$r->{name}" };
	}


	foreach my $ts ( sort keys %{$d} ) {
		push @{$j->{data}}, {
			ts => $ts,
			a  => $d->{$ts}{A},
			w  => $d->{$ts}{W} };
	}

	return $j;
}

sub mode_rdap {
	my ($dbh, $var) = @_;
	my $j = { };


	my %query = (
		'asn' => '
			SELECT rir,rdap,rdaps,descr
			FROM rdap_root_asn
			WHERE ? BETWEEN as_begin AND as_end
			ORDER BY size DESC LIMIT 1',
		'ip4' => '
			SELECT rir,rdap,rdaps,descr
			FROM rdap_root_ip4
			WHERE INET_ATON(?) BETWEEN networkb AND networke
			ORDER BY netmask DESC LIMIT 1',
		'ip6' => '
			SELECT rir,rdap,rdaps,descr
			FROM rdap_root_ip6
			WHERE CONV(HEX(LEFT(INET6_ATON(?),8)),16,10) BETWEEN networkb1 AND networke1
			AND   CONV(HEX(RIGHT(INET6_ATON(?),8)),16,10) BETWEEN networkb2 AND networke2
			ORDER BY netmask DESC LIMIT 1',
	);

	my %objtype = (
		'asn' => 'autnum',
		'ip4' => 'ip',
		'ip6' => 'ip',
	);

	my $q = sqlquery($dbh, "SELECT value FROM rdap_cache WHERE name = ?", $var->{rdapdata});
	my($r) = $q->fetchrow_array();


	if ( !defined $r ) {

		my $x = $var->{rdapdata};
		$x =~ s/\/.*//;

		my @args = ( $x );
		push @args, $x if $var->{rdaptype} eq 'ip6';

		$q = sqlquery($dbh, $query{$var->{rdaptype}}, @args);
		my ($rir,$rdap,$rdaps,$descr) = $q->fetchrow_array();

		$rdap = $rdaps if defined $rdaps;

		if ( defined $descr ) {
			$j->{error} = "IANA Special: " . $descr;
		} elsif ( defined $rdap ) {
			$r = '';
			my $url = sprintf("'%s/%s/%s'", $rdap, $objtype{$var->{rdaptype}}, $var->{rdapdata});
			open(RDAP,"wget -q -O- $url |");
			while(<RDAP>) { $r .= $_; }
			close(RDAP);

			if ( $r eq '' ) {
				$j->{error} = "AS not found in RDAP server ($rir)";
			}
			else {
				sqlquery($dbh,"REPLACE INTO rdap_cache SET name = ?, value = ?, valid = FROM_UNIXTIME(?)",
					$var->{rdapdata}, $r, time() + ( 7 * 86400 ));
			}
		}
	}
	else {
		$j->{rdap} = $r;
	}

	if ( ! exists $j->{rdap} ) {
		$q = sqlquery($dbh, "SELECT value FROM rdap_cache WHERE name = ?", $var->{rdapdata});
		($r) = $q->fetchrow_array();
	}

	if ( defined $r ) {
		$j->{rdap} = from_json($r);
	}

	return $j;
}

sub mode_top100 {
	my ($dbh, $var) = @_;
	my $j = { };

	my $tbl     = $var->{proto} eq 4 ? 'route4' : 'route6';
	my $rnet    = $var->{proto} eq 4 ? 'route_networkb' : 'route_networkb1, route_networkb2';
	my $net     = $var->{proto} eq 4 ? 'networkb' : 'networkb1, networkb2';
	my $rnetq   = $var->{proto} eq 4 ? 'route_networkb=?' : 'route_networkb1=? AND route_networkb2=?';
	my $valid   = ($var->{valid} eq $var->{invalid}) ? undef : ( $var->{valid} eq 'true' ) ? 'valid=1' : 'valid=0';
	my $peerid  = $var->{peerid} ? "AND peerid=$var->{peerid}" : "";
	my $peer_id = $var->{peerid} ? "AND peer_id=$var->{peerid}" : "";
	my $avalid  = defined $valid ? "AND   $valid" : '';

	$j->{route} = [ ];

	if ( $var->{list} eq 'flaps' ) {
		my @r;
		my $q = sqlquery($dbh, "SELECT peerid, $net, netmask, flap_a, flap_w FROM $tbl WHERE 1 $avalid $peerid ORDER BY flap_a DESC LIMIT 100");
		while(my $x = $q->fetchrow_hashref()) { push @r, $x; }

		$q = sqlquery($dbh, "SELECT peerid, $net, netmask, flap_a, flap_w FROM $tbl WHERE 1 $avalid $peerid ORDER BY flap_w DESC LIMIT 100");
		while(my $x = $q->fetchrow_hashref()) { push @r, $x; }

		my %f;

		for(my $i=0; defined $r[$i]; $i++) {

			my $k = sprintf("%s-%s-%s",
				$r[$i]{peerid},
				exists $r[$i]{networkb} ? $r[$i]{networkb} : $r[$i]{networkb1}.':'.$r[$i]{networkb2},
				$r[$i]{netmask});

			if ( ! exists $f{$k} ) {
				$f{$k} = $r[$i]{flap_a} + $r[$i]{flap_w};
			}
		}
		my $cnt=0;
		foreach my $k (reverse sort { $f{$a} <=> $f{$b} } (keys %f) ) {
			last if $cnt>=100;
			my($peerid, $network, $netmask) = split(/-/,$k);
			my @net = split(/:/,$network);
			$q = sqlquery($dbh, "SELECT * FROM view_$tbl WHERE peer_id=? AND $rnetq AND route_netmask=? $avalid", $peerid, @net, $netmask);
			while(my $x = $q->fetchrow_hashref()) { push @{$j->{route}}, $x; }
			$cnt++;
		}
	}
	elsif ( $var->{list} eq 'long_aspath' ) {
			my @aid;
			my $q = sqlquery($dbh, "SELECT id FROM aspath ORDER BY aslen DESC LIMIT 500");
			while(my @x = $q->fetchrow_array()) { push @aid, $x[0]; }

			$q = sqlquery($dbh, "
				SELECT *
				FROM view_$tbl
				WHERE aspath_id IN ( " . join(',',@aid) . " ) $avalid $peer_id
				ORDER BY aslen
				DESC LIMIT ?,?", $var->{pagesize} * $var->{page}, $var->{pagesize});
			while(my $x = $q->fetchrow_hashref()) { push @{$j->{route}}, $x; }
	}
	elsif ( $var->{list} eq 'invalid_asn' ) {
			my @cond;
			my $q = sqlquery($dbh, "SELECT as_begin, as_end FROM rdap_root_asn WHERE descr IS NOT NULL");
			while(my @r = $q->fetchrow_array()) {
				push @cond, sprintf("origin_as BETWEEN %i AND %i", @r);
			}
			$q = sqlquery($dbh, "
				SELECT *
				FROM view_$tbl
				WHERE ( " . join(' OR ', @cond) . ") $avalid $peer_id
				ORDER BY $rnet, route_netmask, peer_id
				LIMIT ?,?", $var->{pagesize} * $var->{page}, $var->{pagesize});
			while(my $x = $q->fetchrow_hashref()) { push @{$j->{route}}, $x; }
	}
	return $j;
}

sub mode_search_prefix {
	my ($dbh, $var) = @_;
	my $j = { };

	my ($ip, $mask, $less);
	if ( $var->{prefix} =~ /^([^\/]+)(\/(\d+))?(\-(\d+))?$/ ) {
		($ip, $mask, $less) = ($1, $3, $5);
	}

	my $q = sqlquery($dbh, "CALL get_route_by_prefix(?,?,?,?,?,?,?,?)",
		$var->{peerid}, $ip, $mask, $less, $var->{pagesize}, $var->{page},
		$var->{valid} eq 'true' ? 1 : 0,
		$var->{invalid} eq 'true' ? 1 : 0
	);
	while(my $r = $q->fetchrow_hashref()) {
		if ( exists $r->{prefix} ) {
			push @{$j->{route}}, $r;
		}
		else {
			my @k = keys %{$r};
			$j->{error} = $r->{$k[0]} if scalar @k;
		}
	}

	$j->{error} = "No results" if ! exists $j->{route} && ! exists $j->{error};

	return $j;
}

sub mode_search_originas {
	my ($dbh, $var) = @_;
	my $j = { 'route' => [ ] };
	my $peerid = $var->{peerid} ? "AND peer_id = $var->{peerid}" : "";
	my $valid = '';
	if ( $var->{valid} ne $var->{invalid} ) {
		$valid = "AND valid=" . ($var->{valid} eq 'true' ? 1 : 0);
	}

	my $q = sqlquery($dbh,
		$var->{proto} eq 4 ?
			"SELECT * FROM view_route4 WHERE origin_as = ? $peerid $valid
			ORDER BY route_networkb,  route_netmask,   peer_id LIMIT ?,?" :

			"SELECT * FROM view_route6 WHERE origin_as = ? $peerid $valid
			ORDER BY route_networkb1, route_networkb2, route_netmask, peer_id LIMIT ?,?",
		$var->{asn}, $var->{page} * $var->{pagesize}, $var->{pagesize});
	while(my $r = $q->fetchrow_hashref()) {
		push @{$j->{route}}, $r;
	}

	$j->{error} = "No results" if ! exists $j->{route} && ! exists $j->{error};

	return $j;
}

sub mode_vis_bgp_updates {
	my ($dbh, $var) = @_;
	my $j = { 'vis' => [ ], 'peer' => [ ] };

	my @peers;

	my $q = sqlquery($dbh,$conf{peer_query} . " ORDER BY id");
	while(my $p = $q->fetchrow_hashref()) {

		if ( $var->{proto} eq 4 && defined $p->{ip4} ) {
			push @peers, $p->{id};
			push @{$j->{peer}}, $p;
		}
		elsif ( $var->{proto} eq 6 && defined $p->{ip6} ) {
			push @peers, $p->{id};
			push @{$j->{peer}}, $p;
		}
	}

	my %d;

	my $maxt = 0;

	$q = sqlquery($dbh, "
		SELECT
			peerid,
			FLOOR( ( UNIX_TIMESTAMP() - UNIX_TIMESTAMP(ts) ) / 60 ) AS backtime,
			name,
			value
		FROM
			stats
		WHERE
			peerid IN (" . join(',',@peers) . ")
		AND
			name IN ('A', 'W')
		AND
			ts > DATE_SUB(NOW(), INTERVAL 6 HOUR)");
	while(my $s = $q->fetchrow_hashref()) {
		$d{$s->{backtime}}{$s->{peerid}}{$s->{name}} = $s->{value};
		if ( $s->{backtime} > $maxt ) { $maxt = $s->{backtime}; }
	}

	for(my $t=0; $t<=$maxt; $t++) {
		my @pd;
		foreach my $peer ( @peers ) {
			my $a = exists $d{$t} && exists $d{$t}{$peer} && exists $d{$t}{$peer}{A} ? $d{$t}{$peer}{A} : 0;
			my $w = exists $d{$t} && exists $d{$t}{$peer} && exists $d{$t}{$peer}{W} ? $d{$t}{$peer}{W} : 0;
			push @pd, { a => $a+0, w => $w+0 };
		}
		push @{$j->{vis}}, [ $t+0, [ @pd ] ];
	}

	return $j;
}

sub mode_vis_border_paths {
	my($dbh, $var) = @_;

	my $j = { 'vis' => { } };

	my $q = sqlquery($dbh, "CALL vis_border_paths(?)", $var->{limit});
	while(my $b = $q->fetchrow_hashref()) {
		$j->{vis}{nodes}{$b->{src}} = 1;
		$j->{vis}{nodes}{$b->{dst}} = 0;
		$j->{vis}{edges}{$b->{src}}{$b->{dst}} = { cnt => $b->{cnt}, proto => $b->{proto} };
	}
	return $j;
}


sub sqlone {
	my $dbh   = shift;
	my $query = shift;
	my @args  = @_;
	my $r = { };

	my $q = sqlquery($dbh, $query, @args);
	while(my $x = $q->fetchrow_hashref()) {
		$r = $x;
	}
	return $r;
}

sub sqlconnect {
	my ($sql) = @_;

	my $dbh = DBI->connect(
		"DBI:mysql:database=$sql->{base};host=$sql->{host}",
		$sql->{user},
		$sql->{pass}, { mysql_enable_utf8 => 1 }
	) || die "Could not connect to database: $DBI::errstr";
	return $dbh;
}

sub sqldisconnect {
	my($dbh) = @_;

	if ( defined $dbh ) {
		$dbh->disconnect();
	}
	$dbh = undef;
}

sub sqlquery {
	my $dbh   = shift;
	my $query = shift;
	my @args  = @_;

	my $t = [gettimeofday];
	my $sth = $dbh->prepare($query);

	if ( !defined $sth->execute(@args) ) {
		print STDERR "QUERY: $query\n";
		print STDERR Dumper(\@args);
	}

	open(F,'>>'.$conf{logfile});
	print F "QUERY: $query\n";
	foreach (@args) {
		print F "ARG: '$_'\n";
	}
	print F sprintf("DURATION: %s\n", tv_interval($t, [gettimeofday]));
	close(F);

	return $sth;
}

sub load_conf {
	my ($file) = @_;

	my $j;

	open(F,$file) || die "Failed to open file '$file'";
	while(<F>) { $j.=$_; }
	close(F);
	return decode_json($j);
}
