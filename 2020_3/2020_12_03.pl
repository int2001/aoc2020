#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my $debug=0;
my $matrix=read_tree();
my $mult=1;
if (1==1) {
	for (my $r=1;$r<8;$r=$r+2) {
		$mult=$mult*tree_check(1,$r,$matrix);
	}
	$mult=$mult*tree_check(2,1,$matrix);
}

#$mult=tree_check(1,7,$matrix);

print "M: ".$mult."\n";

sub tree_check {
	my ($patternd,$patternr,$matrix)=@_;
	my $tree=0;
	my $right=0;
	for (my $down=0;$down<scalar(@{$matrix});$down=$down+$patternd) {
		$right=$right % 11;
		#print "PD: ".$patternd." PR:".$patternr." D:".$down." R:".$right." ->".$matrix->[$down]->[$right]."\n";
		if ($matrix->[$down]->[$right] eq '#') {
			$tree++;
			$matrix->[$down]->[$right]='X';
		} else {
			$matrix->[$down]->[$right]='O';
		}
		$right=$right+$patternr;
	}
	print "PatD: ".$patternd." PatR: ".$patternr." Trees: ".$tree."\n";
	if ($debug) {
		for (my $x=0;$x<scalar(@{$matrix});$x++) {
			for (my $y=0;$y<scalar(@{$matrix->[$x]});$y++) {
				print $matrix->[$x]->[$y];
			}
			print "\n";
		}
	}
	return $tree;
}

sub read_tree {
	my $matrix;
	my $row=0;
	while (my $l=<>) {
		chomp($l);
		my @c=split(//,$l);
		my $col=0;
		foreach my $ch (@c) {
			$matrix->[$row]->[$col++]=$ch;
		}
		$row++;
	}
	return $matrix;
}


