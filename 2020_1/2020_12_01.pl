#!/usr/bin/perl -w

use strict;

my @d;
while (my $in = <>) {
	chomp($in);
	push @d,$in;
}

for (my $i=0;$i<scalar(@d);$i++) {
	for (my $j=0;$j<scalar(@d);$j++) {
		for (my $k=0;$k<scalar(@d);$k++) {
			if (($d[$i]+$d[$j]+$d[$k]) == 2020) {
				my $sumup=($d[$i]*$d[$j]*$d[$k]);
				print $sumup."\n";
			}
		}
	}
}
