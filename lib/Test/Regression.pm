package Test::Regression;

use warnings;
use strict;

=head1 NAME

Test::Regression - Test library that can be run in two modes: once to generate outputs and secondly to compare against them

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

ok_run(sub {print "hello world"}, "hello_world.txt");

=head1 EXPORT

ok_run

=cut

use Test::Builder::Module;
our @ISA    = qw(Test::Builder::Module);
our @EXPORT = qw(ok_regression);
my $CLASS = __PACKAGE__;

=head1 FUNCTIONS

=head2 ok_regression

This function expects two arguments: a CODE ref and a file path. 
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
	if ($@) {
		my $tb = $CLASS->builder;
		$tb->diag($@);
		return $tb->ok(0, $testname);
	}

	# generate the output files if required
	if ($ENV{TEST_REGRESSION_GEN}) {
		return $tb->ok(1, $testname);
	}

	# compare the files
	return $tb->ok(1, $testname);
}

=head1 AUTHOR

Nicholas Bamber, C<< <nicholas at periapt.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-regression at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Regression>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




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
