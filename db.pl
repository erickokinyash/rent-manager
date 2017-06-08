#!/usr/bin/perl
use strict;
use warnings;
use v5.10; # for say() function
use v5.22.2;
use DBI;
 
say "Perl MySQL Create Table Demo";
 
# MySQL database configurations
my $dsn = "DBI:mysql:Users";
my $username = "root";
my $password = '@mermaid1234';
 
# connect to MySQL database
my %attr = (PrintError=>0, RaiseError=>1);
 
my $dbh = DBI->connect($dsn,$username,$password, \%attr);
 
# create table statements
my @ddl =     (
 # create tags table
 "CREATE TABLE clientA (
  reg int(10) NOT NULL,
  name VARCHAR(50) NOT NULL,
  UNIQUE(reg)
 ) ENGINE=InnoDB;",
 
 "CREATE TABLE clientA_payment ( 
   reg int(11) NOT NULL,
   reg_id int(11) references clientA(reg),
   name VARCHAR(50) NOT NULL,
   month varchar(50) NOT NULL,
   payment int(11) NOT NULL,
   balance int(11) NOT NULL,
   FOREIGN KEY (reg_id) REFERENCES clientA(reg) ON DELETE CASCADE,
   UNIQUE (reg)
 ) ENGINE=InnoDB;",

  "CREATE TABLE clientB (
  reg int(11) NOT NULL,
  name VARCHAR(50) NOT NULL,
  UNIQUE(reg)
 ) ENGINE=InnoDB;",
 
 "CREATE TABLE clientB_payment (
   reg int(11) NOT NULL,
   reg_id int(11) references clientB(reg),
   name VARCHAR(50) NOT NULL,
   month varchar(50) NOT NULL,
   payment int(11) NOT NULL,
   balance int(11) NOT NULL,
   FOREIGN KEY (reg_id) REFERENCES clientB(reg) ON DELETE CASCADE,
   UNIQUE (reg)
 ) ENGINE=InnoDB;",
);
 
# execute all create table statements	       
for my $sql(@ddl){
  $dbh->do($sql);
}        
 
say "All tables created successfully!";
 
# disconnect from the MySQL database
$dbh->disconnect();