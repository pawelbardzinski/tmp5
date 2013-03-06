#!/usr/bin/perl -w
use Time::HiRes qw(usleep);
my $filename = "/blazeds/tomcat/webapps/alive5/Alive6_HiRes/time.txt";

while (1)	{
	usleep (1000000);
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	open (F,">$filename");
	print F $min.':'.$sec;
	close (F);
}
