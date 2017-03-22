#!/bin/env perl
use strict;
use warnings;
use autodie;
use v5.10;

use Test::More;

use File::Slurper qw( read_text );

system('./extract_barcoded_fastq_with_max_length sample.fastq barcodes 50');

system('gunzip -c sample.fastq.barcode_filtered.fastq.gz > result.fastq');
system('gunzip -c sample.fastq.unmatched.fastq.gz > unmatched.fastq');

my $result = read_text( 'result.fastq');

my $expected = read_text ( 'expected.fastq' );

is($result, $expected, 'Correctly filterd FASTQ file');

unlink 'sample.fastq.unmatched.fastq.gz';
unlink 'sample.fastq.barcode_filtered.fastq.gz';
unlink 'result.fastq';
unlink 'unmatched.fastq';


done_testing();

