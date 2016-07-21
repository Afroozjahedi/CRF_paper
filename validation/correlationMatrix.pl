#! /usr/bin/perl 

use strict; 
use warnings; 
use diagnostics; 

# $ scalar variables 
my $i = 0;
my $k = 0;
my $line; 
my $data;
my $processing; 

# @ arrays 
my @connections; 
my @data; 
my @rows; 


#opendir (DIR, "/Volumes/Purkinje/SVM-RFE/corrmats_colleen_cohort_150") or die "$!";
#opendir (DIR, "/Volumes/Turing/ABIDE_Power/corrmats_colleen_allROI") or die "$!";
opendir (DIR, "/Volumes/Turing/ABIDE_Power/CRF/CRF_corrmats_.5mm") or die "$!"; 


my $file = "/Volumes/Turing/ABIDE_Power/CRF/inHouse_Output.txt"; # CHANGE THE FILE NAME! 
open my $ounit, ">>$file" or die "Could not open file: $!";
	
while(my $file= readdir(DIR))
{
next if ($file =~ m/^\./); 
   open(FH,"/Volumes/Turing/ABIDE_Power/CRF/CRF_corrmats_.5mm/$file") or die "$!";
   print "$file\n";
   if($file =~ m/A.*_corrmat.1D/)
   {   
   	push @data, "ASD" ;
   }
   else
   {
   	push @data, "TD";
   }
   my $rowcount = 1;
   while (<FH>)
   { 
    	$line = $_; 
		chomp($line);
	
	@connections = split(" ", $line);   
	
	print "There are " .scalar(@connections)." (should be 264) connectivity measures in this $rowcount th row.\n"; 
				
  		push @data, @connections[0..$rowcount-2];
   
    $rowcount++; 
   }
   close(FH);
   print "There are " .scalar(@data)." connectivity measures for this subject (including the class label).\n";


	# $file = "./ABIDE_allsubjects.txt";
# 	open my $ounit, ">>$file" or die "Could not open file: $!";
	print $ounit "@data\n";
	# close $ounit;

	@data = ();	# empty array
}

close $ounit;
