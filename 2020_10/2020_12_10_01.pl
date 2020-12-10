#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my @data=get_data();
@data = sort { $a <=> $b }  @data;

my $lastadapter=0;
my $jo;

for (my $i=0;$i<scalar(@data);$i++) {
	if (($data[$i]-$lastadapter)<=3) {
		$jo->{($data[$i]-$lastadapter)}++;
		$lastadapter=$data[$i];
	}
}
$jo->{3}++;

foreach my $jodiff (keys $jo) {
	print $jodiff." times ".$jo->{$jodiff}."\n";
}

print "Final: ".($jo->{1}+($jo->{3}*3))."\n";
print "Result: ".($jo->{1}*$jo->{3})."\n";
sub get_data {
	my @data;
	while (my $l=<>) {
		chomp($l);
		push @data,$l;
	}
	return @data;
}
