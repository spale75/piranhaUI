#!/usr/bin/perl

use strict;
use DBI;
use JSON;
use Data::Dumper;

$|=1;

my($file) = @ARGV;

if ( !defined $file ) {
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

# delete tables
foreach my $wild (qw(peer_rbuf_% route4 route6)) {
	my $q = sqlquery($dbh,"SHOW TABLES LIKE '$wild'");
	while(my @x = $q->fetchrow_array()) {
		print "DROP		$x[0]\n";
		sqlquery($dbh,"DROP TABLE $x[0]");
	}
}

# truncate tables
foreach my $tbl (qw(community nexthop)) {
	print "TRUNCATE	$tbl\n";
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
