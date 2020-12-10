#!/usr/bin/perl -w

use strict;

my $btree=get_tree();
my @pbags=check_bag('shiny gold');
@pbags=uniq(@pbags);

print scalar(@pbags)." Bags\n";

sub check_bag {
	my ($which)=@_;
	my @pbags=();
	my $hpb;
	foreach my $cont (keys $btree) {
		if ( (defined($btree->{$cont}->{$which})) && ($btree->{$cont}->{$which} > 0) ) {
			push @pbags,$cont;
			$hpb->{$cont}++;
		}
	}
	if (scalar(keys %{$hpb})>0) {
		foreach my $bag (keys %{$hpb}) {
			my @bb = check_bag($bag);
			push(@pbags,@bb) if (scalar(@bb)>0);
		}
	}
	return @pbags;
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

sub uniq {
	my %seen;
	grep !$seen{$_}++, @_;
}
