#!/usr/bin/perl -w

use strict;
use Data::Dumper;

my $data=get_data();
#print Dumper $data;

my $done;
my $acc=0;
my $ip=0;
while (1) {
	my ($cmd,$arg)=split(/\ /,$data->[$ip]);
	$ip++;
	$done->{$ip-1}++;
	last if ( ($ip>=scalar(@{$data})) || (defined($done->{$ip-1}) && ($done->{$ip-1}>1)));
	$acc+=$arg*1 if ($cmd eq 'acc');
	$ip+=$arg*1-1 if ($cmd eq 'jmp');
}
print "Accu has: ".$acc."\n";

sub get_data {
	my $data;
	while (my $l=<>) {
		chomp ($l);
		push(@{$data},$l);
	}
	return $data;
}
