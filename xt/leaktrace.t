use strict;
use warnings;
use Digest::Groestl;
use Test::More;

eval "use Test::LeakTrace; 1" or do {
    plan skip_all => 'Test::LeakTrace is not installed.';
};
plan tests => 1;

my $try = sub {
    my $groestl = Digest::Groestl->new(224);
    $groestl->add('foobar');
};

$try->();

is(leaked_count($try), 0, 'leaks');
