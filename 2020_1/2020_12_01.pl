#!/usr/bin/perl -w

use strict;

my ($p1,$p2);
my @d;
while (my $in = <>) {
	chomp($in);
	push @d,$in;
}

for (my $i=0;$i<scalar(@d);$i++) {
	for (my $j=0;$j<scalar(@d);$j++) {
		$p1="Part 1: ".($d[$i]*$d[$j])."\n" if (($d[$i]+$d[$j]) == 2020);
		for (my $k=0;$k<scalar(@d);$k++) {
			if (($d[$i]+$d[$j]+$d[$k]) == 2020) {
				my $sumup=($d[$i]*$d[$j]*$d[$k]);
				$p2="Part 2: ".$sumup."\n";
			}
		}
	}
}
print $p1;
print $p2;
