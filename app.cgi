#!/usr/sbin/perl
print "Content-type: text/html\n\n";
use CGI;
use DBI;
use DBD::mysql;
use CGI::Carp qw (fatalsToBrowser);

# MySQL database configurations
my $dsn = "DBI:mysql:Users";
my $username = "root";
my $password = '@mermaid1234';

$q = CGI->new;
$query=CGI->new;
# connect to MySQL database
my %attr = (PrintError=>0, RaiseError=>1);
my $dbh = DBI->connect($dsn,$username,$password, \%attr);

my $regi = $query->param('number');
my $name = $query->param('name');

print $q->header; 

$sth = $dbh->prepare("Insert into clientA(reg,name) values(?,?)");
$sth->execute($regi,$name);
$sth = $connect->prepare($sql)
or die "Can't prepare $sql: $connect->errstrn";
#pass sql query to database handle..

#$rv = $sth->execute
#or die "can't execute the query: $sth->errstrn";
#execute your query

#if ($rv==1){
#print "Record has been successfully updated !!!n";
#}else{
#print "Error!!while inserting recordn";
#exit;
#}
$sth->finish() or die $DBI::errstr;;
$dbh->disconnect() or die $DBI::errstr;;