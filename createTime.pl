#!/usr/bin/perl -w

my $filename = "/tmp5/time.txt";

while (1)	{
	sleep 1;
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	open (F,">$filename");
	print F $min.':'.$sec;
	close (F);
}
