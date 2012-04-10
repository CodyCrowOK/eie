#!/usr/bin/perl

use strict;
use warnings;
use feature ":5.10";
use File::Path qw(remove_tree);
use Digest::SHA1 qw(sha1);
use File::Cat;
use File::Touch;
use File::Slurp;
use File::Copy;

our $eie_dir = ".eie";

#create directories and what have you
sub eie_init() {
	mkdir $eie_dir or die("Could not create eie directory.\n");
	mkdir "${eie_dir}/store" or die("Could not create eie directory.\n");
	mkdir "${eie_dir}/info" or die("Could not create eie directory.\n");
	touch("${eie_dir}/addfiles") or die $!;
}
sub eie_commit() {
	my @commit_files = split('/\n/', "${eie_dir}/addfiles") or die $!;
	
	my $commit_time = time;
	foreach (@commit_files) {
		if ($_ ne '') {
			#write files
			my $file_contents = read_file("$_") or die $!;
			my $file_sha1 = sha1($file_contents);
			my $destination = "${eie_dir}/store/".$commit_time."_".$file_sha1;
			copy("$_", $destination) or die $!;
			#write info
			touch("${eie_dir}/info/${commit_time}") or die $!;
			open(my $info_file, ">>", "${eie_dir}/store/${commit_time}") or die $!;
			my $info_string = "${_},${destination}";
			print $info_file $info_string."\n";
			close $info_file;
		}
	}
}
sub eie_clean() {
	remove_tree($eie_dir) or die("Could not rm eie directory.\n");
}

#Adds @ARGV's to list of files to be processed on commit.
sub eie_add() {
	foreach (@ARGV) {
		if ($_  ne "add") {
			open(my $addfiles_file, ">>", "${eie_dir}/addfiles") or die $!;
			print $addfiles_file $_."\n";
			close $addfiles_file;
		}
	}
	
}
			

given($ARGV[0]) {
	when ("init") {
		eie_init();
		break;
	}
	when ("add") {
		eie_add();
		break;
	}
	when ("commit") {
		eie_commit();
		break;
	}
	when ("clean") {
		eie_clean();
		break;
	}
}