#!/usr/bin/perl

use strict;
use warnings;
use feature ":5.10";
use File::Path qw(make_path remove_tree);

our $eie_dir = ".eie";

sub eie_init() {
	mkdir $eie_dir or die("Could not create eie directory.\n");
}

sub eie_clean() {
	remove_tree($eie_dir) or die("Could not rm eie directory.\n");
}

given($ARGV[0]) {
	when ("init") {
		eie_init();
		break;
	}
	when ("add") {
		break;
	}
	when ("commit") {
		break;
	}
	when ("clean") {
		eie_clean();
		break;
	}
}