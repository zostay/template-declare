use strict;
use warnings;

BEGIN {
    use Test::More;

    eval 'use MooseX::Declare';
    plan skip_all => 'You must have MooseX::Declare to run this test. Mynd you, møøse bites Kan be pretty nasti...'
        if $@;
}

role KarvedMoose { }

class NiceMoose {

    use Template::Declare::Tags qw( -moose_friendly HTML );

    with qw( KarvedMoose );

}

plan tests => 2;

my $obj = NiceMoose->new;
is($obj->meta->name, 'NiceMoose', 'got a NiceMoose in meta');

ok($obj->does('KarvedMoose'), 'this NiceMoose is a KarvedMoose');

