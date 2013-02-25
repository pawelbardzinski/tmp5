#!/usr/bin/perl 

if ($ARGV[0] eq '')	{
	print "Usage: perl lineCount5.pl <input/output CSV file>\n";
	exit -1;
}

my $touchfile = '/tmp5/touch.txt';
my $datefile = '/tmp5/date.txt';
my $timefile = '/tmp5/time.txt';

open (T, "<$timefile");
my $time_ = <T>;
close (T);
($hr_,$mn_) = split(':',$time_);
my $cline = ($hr_*30)+($mn_/2);
open (F, "<$ARGV[0]");
my @lines = <F>;
close (F);
my $line = '';

foreach $thing (@lines)	{
	if ($thing =~ m/^[a-z]/i)	{
		$line .= $count." ";
		$count = 0;
	}	else	{
		$count++;
	}
}
$line .= $count;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$mon++;
my $Month;
if ($mon == 1)	{ $Month = 'Jan'; }
if ($mon == 2)	{ $Month = 'Feb'; }
if ($mon == 3)	{ $Month = 'Mar'; }
if ($mon == 4)	{ $Month = 'Apr'; }
if ($mon == 5)	{ $Month = 'May'; }
if ($mon == 6)	{ $Month = 'Jun'; }
if ($mon == 7)	{ $Month = 'Jul'; }
if ($mon == 8)	{ $Month = 'Aug'; }
if ($mon == 9)	{ $Month = 'Sep'; }
if ($mon == 10)	{ $Month = 'Oct'; }
if ($mon == 11)	{ $Month = 'Nov'; }
if ($mon == 12)	{ $Month = 'Dec'; }
my $Wday;
if ($wday == 1) { $Wday = 'Mon'; }
if ($wday == 2) { $Wday = 'Tue'; }
if ($wday == 3) { $Wday = 'Wed'; }
if ($wday == 4) { $Wday = 'Thu'; }
if ($wday == 5) { $Wday = 'Fri'; }
if ($wday == 6) { $Wday = 'Sat'; }
if ($wday == 0) { $Wday = 'Sun'; }

my $today = $mday." ".$Month." ".($year+1900)." ".$Wday."\n";  
my $weekend = 'weekday';  
if ((($Wday eq 'Sat') || ($Wday eq 'Sun')) || (($Wday eq 'Fri') && (($hour eq '18') || ($hour eq '19') || ($hour eq '20') || ($hour eq '21') || ($hour eq '22') || ($hour eq '23'))))		{
	$weekend = 'weeekend';
}

open (Fd, "<$datefile");
my @date_data = <Fd>;
close (Fd);

if ($date_data[$#date_data] ne $today)	{
	if ($#date_data >= 2)	{
		my @newD;
		$newD[0] = $date_data[1];
		$newD[1] = $date_data[2];
		@date_data = '';
		@date_data = @newD;
	}
	push (@date_data, $today);
	open (Fd, ">$datefile");
	foreach (@date_data)	{
		print Fd $_;
	}
	close Fd;
}

$line = $line."\n";

foreach (@date_data)	{
	$line .= $_;
}       

$cline .= "\n";

open (G, ">>$ARGV[0]");
print G $line;
print G $cline;      
print G $weekend;
close (G);
open (Z, ">>/tmp5/latest_data2.csv");
print Z $cline;  
print Z $weekend;
close (Z);

system ('zip /tmp5/data2.zip /tmp5/data2.csv');
system ('cp /tmp5/data2.zip /blazeds/tomcat/webapps/ROOT/data.zip');
system ('cp /tmp5/latest_data2.csv /tmp5/latest_data.csv');
system ('cp /tmp5/latest_data2.csv /blazeds/tomcat/webapps/alive5/Alive6_HiRes/latest_data.csv');

open (F, ">$touchfile");
close (F);    

system ('cp /tmp5/data2.zip /blazeds/tomcat/webapps/alive5/Alive5/data.zip');
system ('cp /tmp5/data2.zip /blazeds/tomcat/webapps/alive5/Alive6_HiRes/data.zip');
system ('cp /tmp5/data2.zip /blazeds/tomcat/webapps/alive5/Alive6_MedRes/data.zip');
system ('cp /tmp5/data2.zip /blazeds/tomcat/webapps/alive5/Alive6_LowRes/data.zip');
system ('cp /tmp5/time.txt /blazeds/tomcat/webapps/alive5/Alive5/time.txt');
system ('cp /tmp5/time.txt /blazeds/tomcat/webapps/alive5/Alive6_HiRes/time.txt');
system ('cp /tmp5/time.txt /blazeds/tomcat/webapps/alive5/Alive6_MedRes/time.txt');
system ('cp /tmp5/time.txt /blazeds/tomcat/webapps/alive5/Alive6_LowRes/time.txt');
