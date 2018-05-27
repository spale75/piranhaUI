#!/usr/bin/perl

use strict;
use DBI;
use Socket6;
use Data::Dumper;
use JSON;
use File::Basename;


$|=1;

my ($file) = @ARGV;

$file = dirname($0) . '/../etc/config.json' if !defined $file;

if ( !defined $file ) {
	print STDERR "Usage: $0 <config file>\n";
	exit 1;
}

my $conf = load_conf($file);

my %rdap = (
	'asn' => {
		bootstrap => 'http://data.iana.org/rdap/asn.json',
		special => [
			[ 64496, 64511, "Documentation and sample code" ],
			[ 64512, 65534, "Private Use" ],
			[ 65535, 65535, "Reserved" ],
			[ 65536, 65551, "Documentation and sample code" ],
			[ 65552, 131071, "Reserved" ],
			[ 4200000000, 4294967294, "Private Use" ],
			[ 4294967295, 4294967295, "Reserved" ],
		],
	},
	'ip4' => {
		bootstrap => 'http://data.iana.org/rdap/ipv4.json',
		'special' => [
			[ '0.0.0.0/8', "IANA - Local Identification" ],
			[ '10.0.0.0/8', 'RFC1918 - Private Use' ],
			[ '100.64.0.0/10', 'Shared Address Space' ],
			[ '127.0.0.0/8', 'Loopback' ],
			[ '169.254.0.0/16', 'Link Local' ],
			[ '192.88.99.0/24', 'reserved for 6to4 Relay Anycast' ],
			[ '192.0.0.0/24', 'reserved for IANA IPv4 Special Purpose Address Registry' ],
			[ '198.18.0.0/15', 'reserved for Network Interconnect Device Benchmark Testing' ],
			[ '198.51.100.0/24', 'reserved for TEST-NET-2' ],
			[ '203.0.113.0/24', 'reserved for TEST-NET-3' ],
			[ '224.0.0.0/3', 'reserved for Multicast' ],
			[ '192.0.2.0/24', 'TEST-NET-1' ],
			[ '192.168.0.0/16', 'RFC1918 - Private Use' ],
			[ '172.16.0.0/12', 'RFC1918 - Private Use' ],
		],
	},
	'ip6' => {
		bootstrap => 'http://data.iana.org/rdap/ipv6.json',
		'special' => [
			[ '0000::/8', "Reserved by IETF" ],
			[ '0100::/8', "Reserved by IETF" ],
			[ '0200::/7', "Reserved by IETF" ],
			[ '0400::/6', "Reserved by IETF" ],
			[ '0800::/5', "Reserved by IETF" ],
			[ '1000::/4', "Reserved by IETF" ],
			[ '4000::/3', "Reserved by IETF" ],
			[ '6000::/3', "Reserved by IETF" ],
			[ '8000::/3', "Reserved by IETF" ],
			[ 'a000::/3', "Reserved by IETF" ],
			[ 'c000::/3', "Reserved by IETF" ],
			[ 'e000::/4', "Reserved by IETF" ],
			[ 'f000::/5', "Reserved by IETF" ],
			[ 'f800::/6', "Reserved by IETF" ],
			[ 'fc00::/7', "Unique Local Unicast" ],
			[ 'fe00::/9', "Reserved by IETF" ],
			[ 'fe80::/10', 'Link-Scoped Unicast' ],
			[ 'fec0::/10', 'Reserved by IETRF' ],
			[ 'ff00::/8', 'IETF Multicast' ],
		],
	},
);

my $dbh = sqlconnect($conf->{sql});

foreach my $t ( keys %rdap ) {
	process_rdap($dbh, $t);
}
print "="x80 . "\n";


sub process_rdap {
	my($dbh, $type) = @_;


	my $x = from_json(wget($rdap{$type}{bootstrap}));

	print "="x80 . "\n";
	printf("= %-76s =\n", "Downloading: $rdap{$type}{bootstrap}");
	printf("= %-76s =\n", $x->{description});
	printf("= %-76s =\n", "Published $x->{publication}");
	
	sqlquery($dbh, "TRUNCATE TABLE rdap_root_$type");

	my $cnt = 0;

	if ( $type eq 'asn' ) {

		foreach my $x ( @{$rdap{$type}{special}} ) {
			sqlquery($dbh,"
				REPLACE INTO rdap_root_asn
				SET
					as_begin = ?,
					as_end   = ?,
					rir      = 'iana',
					descr    = ?", @{$x});
			$cnt++;
		}

	}
	elsif ( $type eq 'ip4' ) {

		foreach my $x ( @{$rdap{$type}{special}} ) {
			sqlquery($dbh,"
				REPLACE INTO rdap_root_ip4
				SET
					networkb = inet_aton(?),
					netmask  = ?,
					rir      = 'iana',
					descr    = ?", split(/\//,$x->[0]), $x->[1]);
			$cnt++;
		}
	}
	elsif ( $type eq 'ip6' ) {
		foreach my $x ( @{$rdap{$type}{special}} ) {
			my($net,$mask) = split(/\//,$x->[0]);
			sqlquery($dbh,"
				REPLACE INTO rdap_root_ip6
				SET
					networkb1 = CONV(HEX(LEFT(inet6_aton(?),8)),16,10),
					networkb2 = CONV(HEX(RIGHT(inet6_aton(?),8)),16,10),
					netmask   = ?,
					rir       = 'iana',
					descr     = ?", $net, $net, $mask, $x->[1]);
			$cnt++;
		}
	}

	printf("= %-76s =\n", "Inserted $cnt special objects");

	$cnt=0;

	foreach my $svc ( @{$x->{services}} ) {
		my $data     = $svc->[0];
		my $rdaplist = $svc->[1];
		my ($rdap, $rdaps, $rir);

		foreach ( @{$rdaplist} ) {
			if    ( /^https:/ ) { $rdaps = $_; }
			elsif ( /^http:/  ) { $rdap  = $_; }
		}

		if ( defined $rdap  && $rdap  =~ /\.([^\.]+)\.[^\.]+\// ) { $rir = $1; }
		if ( defined $rdaps && $rdaps =~ /\.([^\.]+)\.[^\.]+\// ) { $rir = $1; }

		$rdap  =~ s/\/$// if defined $rdap;
		$rdaps =~ s/\/$// if defined $rdaps;

		if ( $type eq 'asn' ) {

			foreach my $asr ( @{$data} ) {
				my ($asb, $ase) = split(/-/,$asr);

				$ase = $asb if !defined $ase;

				sqlquery($dbh, "
					REPLACE INTO rdap_root_asn
					SET
						as_begin = ?,
						as_end   = ?,
						rir      = ?,
						rdap     = ?,
						rdaps    = ?", $asb, $ase, $rir, $rdap, $rdaps);
				$cnt++;
			}
		}
		elsif ( $type eq 'ip4' ) {

			foreach my $ip ( @{$data} ) {
				my ($prefix, $netmask) = split(/\//,$ip);

				sqlquery($dbh, "
					REPLACE INTO rdap_root_ip4
					SET
						networkb = inet_aton(?),
						netmask  = ?,
						rir      = ?,
						rdap     = ?,
						rdaps    = ?", $prefix, $netmask, $rir, $rdap, $rdaps);
				$cnt++;
			}
		}
		elsif ( $type eq 'ip6' ) {

			foreach my $ip ( @{$data} ) {
				my ($prefix, $netmask) = split(/\//,$ip);
		
				sqlquery($dbh, "
					REPLACE INTO rdap_root_ip6
					SET
						networkb1 = CONV(HEX(LEFT(inet6_aton(?),8)),16,10),
						networkb2 = CONV(HEX(RIGHT(inet6_aton(?),8)),16,10),
						netmask  = ?,
						rir      = ?,
						rdap     = ?,
						rdaps    = ?", $prefix, $prefix, $netmask, $rir, $rdap, $rdaps);
				$cnt++;
			}
		}

		printf("= %-76s =\n", "Inserted $cnt objects for $rir");
	}
}

sub wget {
	my($file) = @_;

	my $d = '';
	open(W,"wget -q -O- $file |");
	while(<W>) {
		chomp;
		$d .= $_ . "\n";
	}
	close(W);

	return $d;
}

sub sqlconnect {
	my ($sql) = @_;

	my $dbh = DBI->connect(
		"DBI:mysql:database=$sql->{base};host=$sql->{host}",
		$sql->{user},
		$sql->{pass},
	) || die "Could not connect to database: $DBI::errstr";
	return $dbh;
}

sub sqlquery {
	my $dbh   = shift;
	my $query = shift;
	my @args  = @_;

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
