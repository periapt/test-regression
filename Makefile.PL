use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Regression',
    AUTHOR              => q{Nicholas Bamber <nicholas@periapt.co.uk>},
    VERSION_FROM        => 'lib/Test/Regression.pm',
    ABSTRACT_FROM       => 'lib/Test/Regression.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'Test::Differences' => 0,
	'Text::Diff' => 0,
	'Algorithm::Diff' => 0
    },
    LICENSE		=> 'perl',
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Regression-*' },
);
