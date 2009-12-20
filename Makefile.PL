#!perl
use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile1(
    LICENSE => 'perl',
    MIN_PERL_VERSION => '5.006',
    META_MERGE => {
        resources => {
            repository => 'http://github.com/gitpan/B-Lint-StrictOO',
        },
    },
    BUILD_REQUIRES => {
        'IPC::Run' => 0,
    },
    NAME          => 'B::Lint::StrictOO',
    AUTHOR        => 'Josh ben Jore <jjore@cpan.org>',
    VERSION_FROM  => 'lib/B/Lint/StrictOO.pm',
    ABSTRACT_FROM => 'lib/B/Lint/StrictOO.pm',
    PREREQ_PM     => {
        # Lint 1.09+ had working plugins
        'B::Lint'     => '1.09',

        'File::Slurp' => 0,

        # Utils 0.09 the B::OP::siblings method was busted
        'B::Utils'    => '0.10',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'B-Lint-StrictOO-*' },
);

sub WriteMakefile1 {  #Written by Alexandr Ciornii, version 0.21. Added by eumm-upgrade.
    my %params=@_;
    my $eumm_version=$ExtUtils::MakeMaker::VERSION;
    $eumm_version=eval $eumm_version;
    die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
    die "License not specified" if not exists $params{LICENSE};
    if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
        #EUMM 6.5502 has problems with BUILD_REQUIRES
        $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
        delete $params{BUILD_REQUIRES};
    }
    delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
    delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
    delete $params{META_MERGE} if $eumm_version < 6.46;
    delete $params{META_ADD} if $eumm_version < 6.46;
    delete $params{LICENSE} if $eumm_version < 6.31;
    delete $params{AUTHOR} if $] < 5.005;
    delete $params{ABSTRACT_FROM} if $] < 5.005;
    delete $params{BINARY_LOCATION} if $] < 5.005;

    WriteMakefile(%params);
}
