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
			} elsif (($data[$y][$x] eq '#') && ($o >= 4)) {
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
	}
	return $result;
}
		
sub check_around {
	my ($x,$y)=@_;
	my $occ=0;
	$occ++ if checkarr($x-1,$y,'#'); 
	$occ++ if checkarr($x,$y-1,'#');
	$occ++ if checkarr($x-1,$y-1,'#');
	$occ++ if checkarr($x+1,$y,'#');
	$occ++ if checkarr($x,$y+1,'#');
	$occ++ if checkarr($x+1,$y+1,'#');
	$occ++ if checkarr($x+1,$y-1,'#');
	$occ++ if checkarr($x-1,$y+1,'#');
	return ($occ);
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
