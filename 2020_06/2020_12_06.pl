#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my $empty;
my $c;
my $uniq=0;

while (my $l=<>) {
	chomp($l);
	if ($l eq '') {
		$c=$empty;
	} else {
		my @chars=split(//,$l);
		for (my $i=0;$i<scalar(@chars);$i++) {
			$uniq++ if (!(defined($c->{$chars[$i]})));
			$c->{$chars[$i]}++;
		}
	}
}

print $uniq."\n";
