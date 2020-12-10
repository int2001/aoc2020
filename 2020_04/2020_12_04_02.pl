#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my $passport=read_passports();
my $valid=0;
for (my $i=0;$i<scalar(@{$passport});$i++) {
	$valid++ if ( (defined($passport->[$i]->{'ecl'})) && ($passport->[$i]->{'ecl'} =~ m/^(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)/g) &&
			(defined($passport->[$i]->{'pid'})) && ($passport->[$i]->{'pid'} =~ m/^\d{9,9}$/g) &&
			(defined($passport->[$i]->{'eyr'})) && ( (1*$passport->[$i]->{'eyr'} >= 2020) && (1*$passport->[$i]->{'eyr'} <= 2030) ) &&
			(defined($passport->[$i]->{'hcl'})) && ( $passport->[$i]->{'hcl'} =~ m/^#[0-9a-f]{6,6}/g ) && 
			(defined($passport->[$i]->{'byr'})) && ( (1*$passport->[$i]->{'byr'} >= 1920) && (1*$passport->[$i]->{'byr'} <= 2002) ) &&
			(defined($passport->[$i]->{'iyr'})) && ( (1*$passport->[$i]->{'iyr'} >= 2010) && (1*$passport->[$i]->{'iyr'} <= 2020) ) &&
			(defined($passport->[$i]->{'hgt'})) && ( $passport->[$i]->{'hgt'} =~ m/^((1[5-8][0-9]|19[0-3])cm)|((59|6[0-9]|7[0-6])in)/g )
			);
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

