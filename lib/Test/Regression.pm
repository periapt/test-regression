package Test::Regression;

use warnings;
use strict;
use FileHandle;

=head1 NAME

Test::Regression - Test library that can be run in two modes: once to generate outputs and secondly to compare against them

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';


=head1 SYNOPSIS

use Test::Regression;
ok_regression(sub {return "hello world"}, "t/out/hello_world.txt");

=head1 EXPORT

ok_regression

=cut

use Test::Builder::Module;
use Test::Differences;
use base qw(Test::Builder::Module);
our @EXPORT = qw(ok_regression);
my $CLASS = __PACKAGE__;

=head1 FUNCTIONS

=head2 ok_regression

This function requires two arguments: a CODE ref and a file path. 
The CODE ref is expected to return a SCALAR string which 
can be compared against previous runs.
If the TEST_REGRESSION_GEN is set to a true value, then the CODE ref is run and the 
output written to the file. Otherwise the output of the
file is compared against the contents of the file.
There is a third optional argument which is the test name.

=cut

sub ok_regression {
	my $code_ref = shift;
	my $file = shift;
	my $test_name = shift;
	my $output = eval {&$code_ref();};
	my $tb = $CLASS->builder;
	if ($@) {
		$tb->diag($@);
		return $tb->ok(0, $test_name);
	}

	# generate the output files if required
	if ($ENV{TEST_REGRESSION_GEN}) {
		my $fh = FileHandle->new;
		$fh->open(">$file") ||  return $tb->ok(0, "$test_name: cannot open $file");
		print {$fh} $output || return $tb->ok(0, "actual write failed: $file");
		return $tb->ok($fh->close, $test_name);
	}

	# compare the files
	return $tb->ok(0, "$test_name: cannot read $file") unless -r $file;
	my $fh = FileHandle->new;
	$fh->open("<$file") ||  return $tb->ok(0, "$test_name: cannot open $file");
	my $content = join '', (<$fh>);
	eq_or_diff($output, $content, $test_name);
	return $output eq $file;
}

=head1 AUTHOR

Nicholas Bamber, C<< <nicholas at periapt.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-regression at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Regression>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head2 testing of STDERR

The testing of stderr from this module is not as thorough as I would like. L<Test::Builder::Tester> allows turning
off of stderr checking but not matching by regular expression. Handcrafted efforts currently fall foul of L<Test::Harness>.
Still it is I believe adequately tested in terms of coverage.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Regression


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Regression>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Regression>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Regression>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Regression/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Nicholas Bamber.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Test::Regression
