#!/usr/bin/perl -w

use strict;

my @data=get_data();
my $hits;
my $precnt=25;
my $num2find=-1;

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
		$num2find=$data[$i];
		last;
	}
}

my $candidates->{'max'}=0;
for (my $i=0;$i<scalar(@data);$i++) {
	my $tester=0;
	for (my $j=$i;$j<scalar(@data);$j++) {
		if ($tester == $num2find) {
			if ( ($j-$i) > $candidates->{'max'}) {
				$candidates->{'max'}=($j-$i);
				$candidates->{'low'}=$i;
				$candidates->{'high'}=$j;
			}
			last;
		}
		$tester+=$data[$j];
	}
}

my ($small,$high)=(99999999,-1);
for (my $i=$candidates->{'low'};$i<$candidates->{'high'};$i++) {
	$small=$data[$i] if ($data[$i]<$small);
	$high=$data[$i] if ($data[$i]>$high);
}

print $small."/".$high." -> ".($small+$high)."\n";

sub get_data {
	my @data;
	while (my $l=<>) {
		chomp($l);
		push @data,$l;
	}
	return @data;
}
