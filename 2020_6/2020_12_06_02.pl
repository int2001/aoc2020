#!/usr/bin/perl -w

use strict;

my $empty;
my $c;
my $pers=0;

while (1) {
	my $l=<>;
	chomp($l);
	if ($l ne '') {
		$c->{'persons'}++;
		my @chars=split(//,$l);
		for (my $i=0;$i<scalar(@chars);$i++) {
			$c->{'c'}->{$chars[$i]}++;
		}
	}
	if ( (eof()) || (($l eq '')) ) {
		foreach my $key (keys $c->{'c'}) {
			$pers++ if ($c->{'c'}->{$key} == $c->{'persons'});
		}
		$c=$empty;
	}
	last if eof();
}

print $pers."\n";
