#!/usr/bin/perl -w

use strict;

my $pcnt1=0;
my $pcnt2=0;
while (my $l=<>) {
	chomp($l);
	my ($pol,$pas)=split(/\:/,$l);
	my ($occ,$ch)=split(/\ /,$pol);
	my ($min,$max)=split(/\-/,$occ);
	$pas =~ s/\ //g;
	my @chars = split("", $pas);
	my $cnt1=0;
	my $cnt2=0;
	for (my $i=0;$i<scalar(@chars);$i++) {
		$cnt1++ if ($chars[$i] eq $ch);
		$cnt2++ if (($chars[$i] eq $ch) && ( ($i == ($min-1)) || ($i == ($max-1) )));
	}
	$pcnt1++ if (( $cnt1 >= $min) && ( $cnt1 <= $max) );
	$pcnt2++ if ( $cnt2 == 1);
}
print "Part 1: ".$pcnt1."\n";
print "Part 2: ".$pcnt2."\n";
