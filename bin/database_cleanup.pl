#!/usr/bin/perl

use strict;
use DBI;
use JSON;
use Data::Dumper;
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

my $dbh = sqlconnect($conf->{sql});

print <<EOF;
This process will clean the database erasing all peer data.
It will preserve peer configuration and global configuration.

Press [enter] to continue or CTRL+C to abort.
EOF

while(<STDIN>) { last; }

# clear peer state
my $q = sqlquery($dbh, "SELECT id,ip4,ip6 FROM peer");
while(my($id,$ip4,$ip6) = $q->fetchrow_array()) {
	my $tbl;

	if ( defined $ip4 ) {
		$tbl = 'route4';
	}
	elsif ( defined $ip6 ) {
		$tbl = 'route6';
	}

	if ( defined $tbl ) {
		print "CALL manage_peer($id,'delete');\n";
		sqlquery($dbh,"CALL manage_peer(?,'delete')",$id);
	}

}

# truncate tables
foreach my $tbl (qw(community nexthop aspath stats stats_aspath)) {
	print "TRUNCATE	TABLE $tbl\n";
	sqlquery($dbh,"TRUNCATE TABLE $tbl");
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
