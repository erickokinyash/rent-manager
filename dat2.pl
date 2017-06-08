#!/usr/bin/perl
use strict;
use warnings;
use v5.22.2;
use v5.10; # for say() function
 
use DBI;
&main();
sub main {
print("\nDo you want to insert a new client? (Y/N)?");
my $cmd = '';
chomp($cmd = <STDIN>);
print "\n\n";
if ($cmd =~ m/^[Y]$/i){
    my %con = do './register.pl';
    chdir $con{path};
}elsif($cmd =~ m/^[N]$/i){

#until($cmd eq 'N');

    say "INPUT THE RENT PAYMENT FOR THE RESPECTIVE MONTH";
    print "_______________________________________________";
    print "\n\n";
    # MySQL database configurations
    my $dsn = "DBI:mysql:Users";
    my $username = "root";
    my $password = '@mermaid1234';
 
    say "Perl MySQL INSERT client\n";
    my @clientsA = get_clientsA();
 
    # connect to MySQL database
    my %attr = (PrintError=>0,RaiseError=>1 );
    my $dbh = DBI->connect($dsn,$username,$password,\%attr);

    my $sql = "INSERT INTO clientB_payment(reg,reg_id,name,month,payment,balance)
        VALUES(?,?,?,?,?)";

    my $stmt = $dbh->prepare($sql);
    my $GetRows = $dbh->prepare("SELECT * from clientB_payment");
    $GetRows->execute() || die "Cannot fetch all the rows!\n";
    my $ref = $GetRows->fetchall_arrayref();
    foreach my $link(@clientsA){
      if($stmt->execute($link->{reg},$link->{reg_id},$link->{name},$link->{month}, $link->{payment}, $link->{balance})){
        say "CLIENT $link->{name} INSERTED SUCCESSFULLY";
      }
    }
    print "\n";
    print "\t\tBELOW ARE ALL PAYED MEMBERS";
    print "
+------+-----------+----------------+----------+-----------+----------+
| Reg  | Cli_num   |  Name          | Months   | Payments  | Balances |
+------+-----------+----------------+----------+-----------+----------+\n";
    foreach my $rowref (@$ref)
    {
      print "| ", join('    |   ',@$rowref), "      |","\n";
    
    }
    print "+------+-----------+----------------+----------+-----------+----------+";
    print "\n";
    
    $stmt->finish();
     
    # execute the query
     # disconnect from the MySQL database
    
    $dbh->disconnect();
     
    sub get_clientsA{
       my $cmd = '';
       my @clientsA;
       # get clients detail from the command line
       my($reg,$reg_id,$name,$month,$payment,$balance);
     
       # repeatedly ask for client data from command line
       do{
         print "Enter the Reg_number:";
         chomp($reg = <STDIN>);
         print "Enter the Id_number:";
         chomp($reg_id = <STDIN>);
         print "Enter the name:";
         chomp($name = <STDIN>);
         print "Enter the month: ";
         chomp($month = <STDIN>); 
         print "Enter the payment: ";
         chomp($payment = <STDIN>);     
         $balance = 2500 - $payment;
     
         my %clientA = (reg=> $reg, reg_id=> $reg_id, name=> $name,month=> $month, payment=> $payment, balance=> $balance);
    
    push(@clientsA,\%clientA);
    
         say "
+------+----------+----------------+------+--------+--------+
| Reg  |Cli_number|  Name          |Months|Payments|Balances|
+------+----------+----------------+------+--------+--------+
|  $reg   | $reg_id     | $name    | $month  | $payment   | $balance      |
+------+----------+----------------+------+--------+--------+";
     
         print("\nDo you want to insert another client? (Y/N)?");
         chomp($cmd = <STDIN>);
         $cmd = uc($cmd);
       }until($cmd eq 'N');
       return @clientsA;
    }
  }
}
