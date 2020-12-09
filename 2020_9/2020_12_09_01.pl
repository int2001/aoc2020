#!/usr/bin/perl -w

use strict;

my @data=get_data();
my $hits;
my $precnt=25;

for (my $start=0;$start<(scalar(@data)-$precnt);$start++) {
	for (my $pre=$start;$pre<=($start+$precnt);$pre++) {
		for (my $prex=$start;$prex<=($start+$precnt);$prex++) {
			if ($data[$pre]+$data[$prex] == $data[$start+$precnt]) {
				$hits->[$start+$precnt]++;
			}
		}
	}
}

for (my $i=$precnt;$i<scalar(@{$hits});$i++) {
	if (!(defined($hits->[$i]))) {
		print $i." -> ".$data[$i]."\n";
		last;
	}
}

sub get_data {
	my @data;
	while (my $l=<>) {
		chomp($l);
		push @data,$l;
	}
	return @data;
}
