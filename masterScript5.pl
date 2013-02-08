#!/usr/bin/perl

system ('/usr/bin/perl /tmp5/xmlGenerator53.pl');
if ($? != 0)	{ exit; }
system ('/usr/bin/perl /tmp5/ccc53.pl');
system ('/usr/bin/perl /tmp5/lineCount5.pl /tmp5/data2.csv');
