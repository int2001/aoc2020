#!/usr/bin/perl -w

use strict;
use Data::Dump qw(dump);
my @dirs=qw(N E S W);
my $moves={ 'F'=>0, 'R'=>1, 'L'=>3 };
my @data=get_data();

my $heading=1;
my $position={ 'N'=>0, 'E'=>0 };


for my $i (0..scalar(@data)-1) {
	$heading=get_heading($data[$i]->{'dir'},$heading,$data[$i]->{'amount'});
	next if ($data[$i]->{'dir'} =~ m/^(L|R)$/g);
	my $tempheading=$heading;
	if (defined($moves->{$data[$i]->{'dir'}})) {
		$tempheading=(($heading+$moves->{$data[$i]->{'dir'}})%4);
	} else {
		$tempheading=$data[$i]->{'dir'};
	}
	$position->{'N'}+=$data[$i]->{'amount'} if ($tempheading == 0);
	$position->{'E'}+=$data[$i]->{'amount'} if ($tempheading == 1);
	$position->{'N'}-=$data[$i]->{'amount'} if ($tempheading == 2);
	$position->{'E'}-=$data[$i]->{'amount'} if ($tempheading == 3);
}
print abs($position->{'N'})+abs($position->{'E'})."\n";

sub get_heading {
	my ($direction,$oldheading,$deg)=@_;
	if (defined($moves->{$direction})) {
		if ($direction eq 'F') {
			$direction=$oldheading;
		} else {
			$direction=($oldheading+($moves->{$direction}*int($deg/90)) )%4 
		}
	} else {
		$direction=$oldheading;
	}
	return $direction;
}

sub get_data {
	my @data;
	my $line=0;
	while (my $l=<>) {
		chomp($l);
		$data[$line]->{'dir'}=substr($l,0,1);
		$data[$line]->{'dir'} =~ tr/NESW/0123/;
		$data[$line++]->{'amount'}=substr($l,1,99);
	}
	return @data;
}
