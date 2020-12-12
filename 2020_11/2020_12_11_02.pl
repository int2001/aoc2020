#!/usr/bin/perl 

use strict;
use Storable qw(dclone);

my @data=get_data();
my @roundata;
my $chg=1;

while ($chg>0) {
	@roundata = @{ dclone(\@data) };
	$chg=0;
	for my $y (0..(scalar(@data)-1)) {
		for my $x (0..(scalar(@{$data[$y]})-1)) {
			next if ($data[$y][$x] eq '.');
			my $o = check_around($x,$y);
			if (($data[$y][$x] eq 'L') && ($o == 0)) {
				$roundata[$y][$x]='#';
				$chg++;
			} elsif (($data[$y][$x] eq '#') && ($o >= 5)) {
				$roundata[$y][$x]='L';
				$chg++;
			}
		}
	}
	@data = @{ dclone(\@roundata) };
} 

my $occ=0;
for my $y (0..(scalar(@data)-1)) {
	for my $x (0..(scalar(@{$data[$y]})-1)) {
		$occ+=($data[$y][$x] eq '#');
	}
}

print "Occ.: ".$occ."\n";

sub checkarr {
	my ($arx,$ary,$check)=@_;
	my $result=0;
	if (($ary <= scalar(@data)-1) && ($ary >= 0) && ($arx <= scalar(@{$data[$ary]})-1) && ($arx >=0)) {
		$result=1 if ($data[$ary][$arx] eq $check);
		$result=-1 if ($data[$ary][$arx] eq ".");
	}
	return $result;
}

sub check_around {
	my ($x,$y)=@_;
	my $fulloc=0;
	for my $xc (-1..1) {
		for my $yc (-1..1) {
			next if ( ($xc == 0) && ($yc ==0) );
			my ($origin_x,$origin_y)=($x,$y);
			my $occ=0;
			do {
				$origin_x+=$xc;
				$origin_y+=$yc;
				$occ=checkarr($origin_x,$origin_y,'#');
			} until ($occ >=0);
			$fulloc+=$occ;
		}
	}
	return ($fulloc);
}

sub get_data {
	my @data;
	my $row=0;
	while (my $l=<>) {
		chomp($l);
		push(@{$data[$row++]},split(//,$l));
	}
	return @data;
}
