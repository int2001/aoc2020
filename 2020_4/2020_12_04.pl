#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my $passport=read_passports();
my $valid=0;
for (my $i=0;$i<scalar(@{$passport});$i++) {
	$valid++ if ( (defined($passport->[$i]->{'ecl'})) && 
			(defined($passport->[$i]->{'pid'})) && 
			(defined($passport->[$i]->{'eyr'})) && 
			(defined($passport->[$i]->{'hcl'})) && 
			(defined($passport->[$i]->{'byr'})) && 
			(defined($passport->[$i]->{'iyr'})) && 
			(defined($passport->[$i]->{'hgt'})));
}

print $valid."\n";
#print Dumper $passport;

sub read_passports {
	my $pass=0;
	my $passport;
	while (my $l=<>) {
		chomp($l);
		if ($l ne '') {
			my @keys=split(/\ /,$l);
			for (my $i=0;$i<scalar(@keys);$i++) {
				$keys[$i] =~ s/\ *//g;
				my ($k,$val)=split(/\:/,$keys[$i]);
				$passport->[$pass]->{$k}=$val;
			}
		} else {
			$pass++;
		}
	}
	return $passport;
}

