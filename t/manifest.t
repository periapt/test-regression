use strict;
use warnings;
use Test::More;
use Test::CheckManifest;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

eval { require Test::CheckManifest; };

if ( $@ ) {
   my $msg = 'Test::CheckManifest required to criticise code';
   plan( skip_all => $msg );
}

Test::CheckManifest::ok_manifest({filter=>[qr/\/\.git/,qr/\.bak$/,qr/t\/output\//,qr/\.old$/,qr/Test-Regression\-.*\.tar\.gz$/]});

