#!/usr/bin/perl
use LWP::Simple;
use HTTP::Daemon;
use HTTP::Status;
use DBI;

my $url = 'http://xml.dgcsc.org/xml.cfm?password=E2C2665AA45EA9A52FE1B4993365EBD497FE3A9A&action=GoldB';
my $url_slv = 'http://xml.dgcsc.org/xml.cfm?password=E2C2665AA45EA9A52FE1B4993365EBD497FE3A9A&action=SilverB';
my $url_plt = 'http://xml.dgcsc.org/xml.cfm?password=E2C2665AA45EA9A52FE1B4993365EBD497FE3A9A&action=PlatinumB';
my $url_pld = 'http://xml.dgcsc.org/xml.cfm?password=E2C2665AA45EA9A52FE1B4993365EBD497FE3A9A&action=PalladiumB';

my $filename = '/tmp5/1.csv';

my $url_retrieve_attempts = 5;

my $content = get $url;      

my $counter=0;
unless (defined $content) {
	if ($counter < $url_retrieve_attempts) {
  		$counter++; 
		$content = get $url;
	}
 }        

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
$year += 1900; 
$mon++; 
if ($min % 2 != 0)	{ exit -1; }
if ($hour =~ m/^\d$/)	{ $hour = '0'.$hour; }
if ($min =~ m/^\d$/)	{ $min = '0'.$min; } 
if ($mon =~ m/^\d$/)	{ $mon = '0'.$mon; } 
if ($mday =~ m/^\d$/)	{ $mday = '0'.$mday; }
my $time = "$hour:$min"; 
&checkTime($time, $filename);
open (T, ">/tmp5/time.txt");
print T $time;
close (T);
my $date = $year.'-'.$mon.'-'.$mday; 
        
if (($time eq '00:00') || (($date ne $nd) && ($nd ne '')))	{
	system("mv /tmp5/2.csv /tmp5/3.csv");
	system("mv /tmp5/1.csv /tmp5/2.csv");
	&createFile($filename);
}

if (!(-e $filename))	{
	&createFile($filename);
}

my $dbh = DBI->connect( "DBI:CSV:", undef, undef, { RaiseError => 1, AutoCommit => 1 } );
$dbh = DBI->connect(qq{DBI:CSV:csv_sep_char=\,;});
$dbh->{'csv_tables'}->{'info'} = { 'file' => $filename};
$dbh->{'csv_tables'}->{'info'} = { 'col_names' => ["time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"]};
my $sql_statement_update = "SELECT date FROM info";
my $sth = $dbh->prepare($sql_statement_update);
$sth->execute();
my $array_ref = $sth->fetchall_arrayref({date => 1});
$dbh->disconnect();
$nd = '';
foreach $row (@$array_ref)	{
	my $str = $row->{date};
	if (($str eq '')  || ($str !~ m!\d!)) { 
		next;	
		}	else	{ 
			$nd = $str; 
			last; 
		} 
}

$content =~ m!"ARS">(.+)</Price>!; $ARS = sprintf("%.2f",$1*31.1034768);
$content =~ m!"AUD">(.+)</Price>!; $AUD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"BRL">(.+)</Price>!; $BRL = sprintf("%.2f",$1*31.1034768);
$content =~ m!"CAD">(.+)</Price>!; $CAD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"CHF">(.+)</Price>!; $CHF = sprintf("%.2f",$1*31.1034768);
$content =~ m!"CNY">(.+)</Price>!; $CNY = sprintf("%.2f",$1*31.1034768);
$content =~ m!"COP">(.+)</Price>!; $COP = sprintf("%.0f",$1*31.1034768);
$content =~ m!"EUR">(.+)</Price>!; $EUR = sprintf("%.2f",$1*31.1034768);
$content =~ m!"GBP">(.+)</Price>!; $GBP = sprintf("%.2f",$1*31.1034768);
$content =~ m!"HKD">(.+)</Price>!; $HKD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"IDR">(.+)</Price>!; $IDR = sprintf("%.0f",$1*31.1034768);
$content =~ m!"INR">(.+)</Price>!; $INR = sprintf("%.2f",$1*31.1034768);
$content =~ m!"JPY">(.+)</Price>!; $JPY = sprintf("%.0f",$1*31.1034768);
$content =~ m!"KWD">(.+)</Price>!; $KWD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"MXN">(.+)</Price>!; $MXN = sprintf("%.1f",$1*31.1034768);
$content =~ m!"MYR">(.+)</Price>!; $MYR = sprintf("%.2f",$1*31.1034768);
$content =~ m!"NZD">(.+)</Price>!; $NZD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"PEN">(.+)</Price>!; $PEN = sprintf("%.2f",$1*31.1034768);
$content =~ m!"PHP">(.+)</Price>!; $PHP = sprintf("%.1f",$1*31.1034768);
$content =~ m!"RUR">(.+)</Price>!; $RUR = sprintf("%.1f",$1*31.1034768);
$content =~ m!"SEK">(.+)</Price>!; $SEK = sprintf("%.2f",$1*31.1034768);
$content =~ m!"SGD">(.+)</Price>!; $SGD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"TRY">(.+)</Price>!; $TRY = sprintf("%.2f",$1*31.1034768);
$content =~ m!"USD">(.+)</Price>!; $USD = sprintf("%.2f",$1*31.1034768);
$content =~ m!"VUV">(.+)</Price>!; $VUV = sprintf("%.0f",$1*31.1034768);
$content =~ m!"ZAR">(.+)</Price>!; $ZAR = sprintf("%.2f",$1*31.1034768);

$gldslv_content = get $url_slv;
$gldslv_content =~ m!"USD">(.+?)</Price>!; $gldslv1 = $1*31.1034768; $gldslv = sprintf("%.5f",($USD/$gldslv1));
$gldplt_content = get $url_plt;
$gldplt_content =~ m!"USD">(.+?)</Price>!; $gldplt1 = $1*31.1034768; $gldplt = sprintf("%.5f",($USD/$gldplt1));
$gldpld_content = get $url_pld;
$gldpld_content =~ m!"USD">(.+?)</Price>!; $gldpld1 = $1*31.1034768; $gldpld = sprintf("%.5f",($USD/$gldpld1)); 

my $dbh = DBI->connect( "DBI:CSV:", undef, undef, { RaiseError => 1, AutoCommit => 1 } );
$dbh = DBI->connect(qq{DBI:CSV:csv_sep_char=\,;});
$dbh->{'csv_tables'}->{'info'} = { 'file' => $filename};
$dbh->{'csv_tables'}->{'info'} = { 'col_names' => ["time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"]};
my $sql_statement_update = "UPDATE info SET ARS=\'$ARS\', AUD=\'$AUD\', BRL=\'$BRL\', CAD=\'$CAD\', CHF=\'$CHF\', CNY=\'$CNY\', COP=\'$COP\', EUR=\'$EUR\', GBP=\'$GBP\', HKD=\'$HKD\', IDR=\'$IDR\', INR=\'$INR\', JPY=\'$JPY\', KWD=\'$KWD\', MXN=\'$MXN\', MYR=\'$MYR\', NZD=\'$NZD\', PEN=\'$PEN\', PHP=\'$PHP\', RUR=\'$RUR\', SEK=\'$SEK\', SGD=\'$SGD\', TRY=\'$TRY\', USD=\'$USD\', VUV=\'$VUV\', ZAR=\'$ZAR\', gldslv=\'$gldslv\', gldplt=\'$gldplt\', gldpld=\'$gldpld\', date=\'$date\' WHERE time=\'$time\'";
my $sth = $dbh->prepare($sql_statement_update);
$sth->execute();
$dbh->disconnect();

sub createFile	{
	my $file = shift;
	my @Table = ();
	my $first_row = '"time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"'."\n";
	push (@Table,$first_row);			
	for ($j=0; $j<24; $j++)	{
		for ($i=0; $i<60; $i+=2)	{
			if ($i !~ m!\d\d!) {$i = '0'.$i;}
			if ($j !~ m!\d\d!) {$j = '0'.$j;}
			push (@Table,'"'.$j.':'.$i.'","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""'."\n");
		}
	}
	open F,">$file";
	print F @Table;
	close (F);
}

sub checkTime	{
	my $ttime = shift;
	my $file = shift;
	
	open (F1, "<$file");
	my @cont = <F1>;
	close (F1);
	if ($cont[-1] =~ m/time=\"(.+)\"\ date/)	{
		my $k = $1;
		if ($ttime eq $k)	{
			exit -2;
		}
	} 
}

#31.1034768



