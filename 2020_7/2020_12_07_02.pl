#!/usr/bin/perl -w

use strict;

my $btree=get_tree();
my $bags=check_bag('shiny gold');
 
print "Found ".($bags-1)." bags\n";


sub check_bag {
	my ($which) = @_ ;
	my $cnt = 1;
	foreach my $bag (sort keys %{$btree->{$which}}) {
		$cnt+=$btree->{$which}->{$bag} * check_bag($bag);
	}
	return $cnt;
}

sub get_tree {
	my $bagtree;
	while (my $l=<>) {
		chomp($l);
		$l =~ s/bag(s){0,1}//g;
		my ($mainbag,$container)=split(/contain/,$l);
		$mainbag =~ s/^\ //g;
		$mainbag =~ s/\ +$//g;
		my @cbags=split(/\,/,$container);
		foreach my $cbag (@cbags) {
			$cbag =~ s/^\ //g;
			$cbag =~ s/\ \.?$//g;
			my $cnt=$cbag;
			$cnt =~ s/^(\d{1,3}).*$/$1/g;
			$cbag =~ s/^\d{1,3}\ (.*)$/$1/g;
			$cnt = 0 if ($cnt eq 'no other');
			$bagtree->{$mainbag}->{$cbag}=$cnt;
		}
	}
	return $bagtree;
}

