use strict;
use warnings;

BEGIN {
    use Test::More;

    eval 'use Moose';
    plan skip_all => 'You must use Moose to run this test. A Møøse once bit my sister ...'
        if $@;
}

use Test::More tests => 2;

package KarvedMoose;
use Moose::Role;

package NiceMoose;
use Moose;
use Test::More;

use Template::Declare::Tags qw( -moose_friendly HTML );

with qw( KarvedMoose );

my $obj = NiceMoose->new;
is($obj->meta->name, 'NiceMoose', 'got a NiceMoose in meta');

ok($obj->does('KarvedMoose'), 'this NiceMoose is a KarvedMoose');

