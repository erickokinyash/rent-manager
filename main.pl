use strict;
no warnings 'experimental';
use Switch;
use v5.22.2;
use v5.10; # for say() function
use DBI;

print "WELCOME TO THE GEEKS RENT MANAGEMENT SYSTEM\n\n";
print "1.Plot A\n2.Plot B\n";
#my $num = rand();
print "\nPlease select the Plot to inspect: ";
my $num = <STDIN>;
print "\n";
if ($num == 1) {
    my %con = do './dat.pl';
	chdir $con{path};
}elsif ($num == 2) {
    my %con = do './dat2.pl';
	chdir $con{path};
} else {
    print "Plot you selected does not exist";
}

