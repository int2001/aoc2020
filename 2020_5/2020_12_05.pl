#!/usr/bin/perl -w

use strict;

readem();

sub readem {
	my $maxseat=-1;
	while (my $l=<>) {
		chomp($l);
		my @pass=split(//,$l);
		my $row=calc_me(127,'B','F',0,7,@pass);
		my $col=calc_me(7,'R','L',7,10,@pass);
		my $seat=($row*8)+$col;
		$maxseat=$seat if ($seat>$maxseat);
	}
	print "MaxSeat ".$maxseat."\n";
}

sub calc_me {
	my($seatrange,$up,$dn,$start,$stop,@pass)=@_;
	my $seatbase=0;
	for (my $i=$start;$i<$stop;$i++) {
			if ($pass[$i] eq $dn) {
				$seatrange=$seatrange>>1;
			} elsif ($pass[$i] eq $up) {
				$seatrange=$seatrange>>1;
				$seatbase=$seatbase+$seatrange+1;
			}
	#	print $i.":".$pass[$i]." -> ".$seatbase." / ".$seatrange."\n";
		}
	return $seatbase;
}
