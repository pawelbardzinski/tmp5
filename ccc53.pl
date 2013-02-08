#!/usr/bin/perl 
use DBI;

my $latest_f = '/tmp5/latest_data2.csv';
my $f = '/tmp5/data2.csv';
open (T, "</tmp5/time.txt") || die "can\'t find /tmp5/time.txt!";
my $time_ = <T>;
close (T);

my @latest = ();
my @tdays = ();
my @Array = ("ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld");

#foreach (@Array)	{				
#	createTodayClientCSV($_,'/tmp5/1.csv');
#	}			
foreach (@Array)	{
	create3DaysClientCSV($_,'/tmp5/1.csv','/tmp5/2.csv','/tmp5/3.csv');
	}			

sub createTodayClientCSV	{
	my $code = shift;
	my $filename = shift;

	my $dbh = DBI->connect( "DBI:CSV:", undef, undef, { RaiseError => 1, AutoCommit => 1 } );
	$dbh = DBI->connect(qq{DBI:CSV:csv_sep_char=\,;});
	$dbh->{'csv_tables'}->{'info'} = { 'file' => $filename};
	$dbh->{'csv_tables'}->{'info'} = { 'col_names' => ["time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"]};
	my $sql_statement_update = "SELECT $code,time FROM info";
	my $sth = $dbh->prepare($sql_statement_update);
	$sth->execute();
	my $array_ref = $sth->fetchall_arrayref({$code => 1, time => 1});
	$dbh->disconnect();
	foreach $row (@$array_ref)	{
		if ($row->{$code} eq '')	{ 
			push (@tdays, '""'.','.$row->{time}."\n"); 
		}	else	{ 
			push (@tdays, $row->{$code}.','.$row->{time}."\n"); 
		}
		if ($row->{time} eq $time_)	{
			if ($row->{$code} eq '')	{ 
				push (@latest, '""'.','.$row->{time}."\n"); 
			}	else	{ 
				push (@latest, $row->{$code}.','.$row->{time}."\n"); 
			}
		}
	}
}

sub create3DaysClientCSV	{
	my $code = shift;
	my $filename1 = shift;
	my $filename2 = shift;
	my $filename3 = shift;

	my $dbh1 = DBI->connect( "DBI:CSV:", undef, undef, { RaiseError => 1, AutoCommit => 1 } );
	$dbh1 = DBI->connect(qq{DBI:CSV:csv_sep_char=\,;});
	$dbh1->{'csv_tables'}->{'info1'} = { 'file' => $filename1};
	$dbh1->{'csv_tables'}->{'info1'} = { 'col_names' => ["time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"]};
	my $sql_statement_update1 = "SELECT $code,time FROM info1";
	my $sth1 = $dbh1->prepare($sql_statement_update1);
	$sth1->execute();
	my $array_ref1 = $sth1->fetchall_arrayref({$code => 1, time => 1});
	$dbh1->disconnect();

	my $dbh2 = DBI->connect( "DBI:CSV:", undef, undef, { RaiseError => 1, AutoCommit => 1 } );
	$dbh2 = DBI->connect(qq{DBI:CSV:csv_sep_char=\,;});
	$dbh2->{'csv_tables'}->{'info2'} = { 'file' => $filename2};
	$dbh2->{'csv_tables'}->{'info2'} = { 'col_names' => ["time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"]};
	my $sql_statement_update2 = "SELECT $code,time FROM info2";
	my $sth2 = $dbh2->prepare($sql_statement_update2);
	$sth2->execute();
	my $array_ref2 = $sth2->fetchall_arrayref({$code => 1, time => 1});
	$dbh2->disconnect();

	my $dbh3 = DBI->connect( "DBI:CSV:", undef, undef, { RaiseError => 1, AutoCommit => 1 } );
	$dbh3 = DBI->connect(qq{DBI:CSV:csv_sep_char=\,;});
	$dbh3->{'csv_tables'}->{'info3'} = { 'file' => $filename3};
	$dbh3->{'csv_tables'}->{'info3'} = { 'col_names' => ["time","ARS","AUD","BRL","CAD","CHF","CNY","COP","EUR","GBP","HKD","IDR","INR","JPY","KWD","MXN","MYR","NZD","PEN","PHP","RUR","SEK","SGD","TRY","USD","VUV","ZAR","gldslv","gldplt","gldpld","date"]};
	my $sql_statement_update3 = "SELECT $code,time FROM info3";
	my $sth3 = $dbh3->prepare($sql_statement_update3);
	$sth3->execute();
	my $array_ref3 = $sth3->fetchall_arrayref({$code => 1, time => 1});
	$dbh3->disconnect();

	push (@tdays, $code."\n");
		
	my @arr1 = @$array_ref1;
	my @arr2 = @$array_ref2;
	my @arr3 = @$array_ref3;
	for ($j=1; $j<=$#arr1; $j++)	{
		my $val1 = $arr1[$j]->{$code};
		my $val2 = $arr2[$j]->{$code};
		my $val3 = $arr3[$j]->{$code};
		if ($val1 eq '')  { $val1 = '""'; }
		if ($val2 eq '')  { $val2 = '""'; }
		if ($val3 eq '')  { $val3 = '""'; }
		push (@tdays, $arr1[$j]->{time}.','.$val1.','.$val2.','.$val3."\n");
		if ($arr1[$j]->{time} eq $time_)	{
			push (@latest, $arr1[$j]->{time}.','.$val1.','.$val2.','.$val3."\n"); 
		}
	}
	open (G, ">$latest_f");
	print G @latest;
	close (G);
	open (F, ">$f");
	print F @tdays;
	close (F);
}