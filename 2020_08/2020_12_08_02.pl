#!/usr/bin/perl -w

use strict;
my @realdata=get_data();

my @data=();
for (my $i=0;$i<scalar(@realdata);$i++) {
	@data=@realdata;
	my ($cmd,$arg)=split(/\ /,$data[$i]);
	if ($cmd eq 'jmp') {
		$cmd='nop';
	} elsif ($cmd eq 'nop') {
		$cmd='jmp';
	}
	$data[$i]=$cmd." ".$arg;
	my $acc=calc();
	print "Accu has: ".$acc."\n"  if ($acc > 0);
}

sub calc {
	my ($cmd2invert)=@_;
	my $acc=0;
	my $ip=0;
	my $done;
	while (1) {
		my ($cmd,$arg)=split(/\ /,$data[$ip]);
		$ip++;
		$done->{$ip-1}++;
		$acc=-1 if (defined($done->{$ip-1}) && ($done->{$ip-1}>1));
		last if ( ($ip>=scalar(@data)) || (defined($done->{$ip-1}) && ($done->{$ip-1}>1)));
		$acc+=$arg*1 if ($cmd eq 'acc');
		$ip+=$arg*1-1 if ($cmd eq 'jmp');
	}
	return $acc;
}

sub get_data {
	my @datar;
	while (my $l=<>) {
		chomp ($l);
		push(@datar,$l);
	}
	return @datar;
}
