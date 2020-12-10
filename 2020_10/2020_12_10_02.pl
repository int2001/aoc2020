#!/usr/bin/perl

use strict;

my @data=get_data();
push (@data,0);
@data = sort { $a <=> $b }  @data;

my @allowed;
for (my $i=0;$i<scalar(@data);$i++) {
	$allowed[$i]->{adapter} = $data[$i];
	for (my $step=1;$step<=3;$step++) {
		last unless defined $data[$i+$step];
		push @{ $allowed[$i]->{possible_adapters} }, $i+$step if $data[$i+$step] - $data[$i] <= 3;
	}
}

my $pcnts=cnt_valids(0);
print "Arrangements: ".$pcnts."\n";

sub cnt_valids {
	my ($checkposition)=@_;
	my $chkadapter=$allowed[$checkposition];
	my $cnt=0;
	return 1 if (!(defined($chkadapter->{'possible_adapters'})));
	return $chkadapter->{'pcnt'} if (defined($chkadapter->{'pcnt'}));
	for (my $i=0;$i<scalar(@{$chkadapter->{'possible_adapters'}});$i++) {
		$cnt+=cnt_valids($chkadapter->{'possible_adapters'}->[$i]);
	}
	$chkadapter->{'pcnt'}=$cnt;
	return $cnt;
}

sub get_data {
	my @data;
	while (my $l=<>) {
		chomp($l);
		push @data,$l;
	}
	return @data;
}
