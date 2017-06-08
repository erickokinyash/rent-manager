#!/usr/bin/perl
use strict;
use warnings;
use v5.22.2;
use v5.10; # for say() function
 
use DBI;

say "REGISTER CLIENT TO THE RESPECTIVE PLOT";
print "______________________________________";
print "\n\n";
# MySQL database configurations
my $dsn = "DBI:mysql:Users";
my $username = "root";
my $password = '@mermaid1234';
 
say "Perl MySQL INSERT client\n";
 
# get user's input links
my @client = get_client();
 
# connect to MySQL database
my %attr = (PrintError=>0,RaiseError=>1 );
my $dbh = DBI->connect($dsn,$username,$password,\%attr);

my $sql = "INSERT INTO clientA(reg,name)
    VALUES(?,?)";

my $stmt = $dbh->prepare($sql);
my $GetRows = $dbh->prepare("SELECT * from clientA");
$GetRows->execute() || die "Cannot fetch all the rows!\n";
my $ref = $GetRows->fetchall_arrayref();
foreach my $link(@client){
  if($stmt->execute($link->{reg},$link->{name})){
    say "CLIENT $link->{name} INSERTED SUCCESSFULLY";
  }
}
print "\n";
print "BELOW ARE ALL MEMBERS";
print "
+---------+------------------+
| Cli_num |      Name        |
+---------+------------------+\n";
foreach my $rowref (@$ref)
{
  print "| ", join('    |   ',@$rowref), "    |","\n";
}
print "+---------+------------------+";
print "\n";

$stmt->finish();
 
$dbh->disconnect();
 
sub get_client{
   my $cmd = '';
   my @client;
   # get clients detail from the command line
   my($reg,$name);
 
   # repeatedly ask for client data from command line
   do{
     print "Enter the client_number:";
     chomp($reg = <STDIN>);
     print "Enter the client name: ";
     chomp($name = <STDIN>);
     my %client1 = (reg=> $reg,name=> $name);
     push(@client,\%client1);

     say "
+----------+----------------+
|Cli_number|  Name          |
+----------+----------------+
| $reg     | $name    |
+----------+----------------+";
 
     print("\nDo you want to insert another client? (Y/N)?");
     chomp($cmd = <STDIN>);
     $cmd = uc($cmd);
   }until($cmd eq 'N');
   return @client; 
}
&main();
sub main {
print("\nDo you want to insert payment for a client? (Y/N)?");
my $cmd = '';
chomp($cmd = <STDIN>);
print "\n\n";
  if ($cmd =~ m/^[Y]$/i){
      my %con = do './payments.pl';
      chdir $con{path};
  }elsif($cmd =~ m/^[N]$/i){
    say "GOODBYE!!!!!!!!\n\n"
  }
}