use strict;
use warnings;
use Test::More;
use Test::CheckChanges;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

eval { require Test::CheckChanges; };

if ( $@ ) {
   my $msg = 'Test::CheckChanges required to criticise code';
   plan( skip_all => $msg );
}

Test::CheckChanges::ok_changes();

