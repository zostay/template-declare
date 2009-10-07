use warnings;
use strict;

##############################################################################
package Wifty::Foo;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Foo' };

##############################################################################
package Wifty::Bar;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Bar' };

##############################################################################
package Wifty::Baz;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Baz' };

##############################################################################
package Wifty::Bip;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Bip' };

##############################################################################
package main;
use Test::More tests => 22;

# Check template resolution with the deprecated `roots` parameterx.
ok !Template::Declare->init( roots => ['Wifty::Foo', 'Wifty::Bar'] ),
    'init with Foo and Bar as roots';

is +Template::Declare->show('hello'), 'hello from Bar',
    'Bar should have precedence';

# Check template resolution with the new `dispatch_to` parameter.
ok !Template::Declare->init( dispatch_to => ['Wifty::Foo', 'Wifty::Bar'] ),
    'init to dispatch to Foo and Bar';

is +Template::Declare->show('hello'), 'hello from Foo',
    'Foo should have precedence';

##############################################################################
# Import the Baz templates into Bar.
package Wifty::Bar;
import_templates Wifty::Baz under '/';

##############################################################################
package main;
ok !Template::Declare->init( dispatch_to => ['Wifty::Foo', 'Wifty::Bar'] ),
    'init to dispatch to Foo and Bar again';

is +Template::Declare->show('hello'), 'hello from Foo',
    'Foo should still have precedence';

##############################################################################
# Import the Baz templates into Foo.
package Wifty::Foo;
import_templates Wifty::Baz under '/';

##############################################################################
package main;
ok !Template::Declare->init( dispatch_to => ['Wifty::Foo', 'Wifty::Bar'] ),
    'init to dispatch to Foo and Bar one more time';

is +Template::Declare->show('hello'), 'hello from Baz',
    'Baz::hello should have replaced Foo::hello';

# Now dispatch only to Bip and Foo.
ok !Template::Declare->init( dispatch_to => ['Wifty::Bip', 'Wifty::Foo'] ),
    'init to dispatch to Bip and Foo';

is +Template::Declare->show('hello'), 'hello from Bip',
    'Bip should now have precedence';

##############################################################################
# Now try the same stuff with aliases.
##############################################################################
package Mifty::Foo;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Foo' };

##############################################################################
package Mifty::Bar;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Bar' };

##############################################################################
package Mifty::Baz;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Baz' };

##############################################################################
package Mifty::Bip;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Bip' };

##############################################################################
# Import the Baz templates into Bar.
package Mifty::Bar;
alias Mifty::Baz under '/';

##############################################################################
package main;
ok !Template::Declare->init( dispatch_to => ['Mifty::Foo', 'Mifty::Bar'] ),
    'init to dispatch to Mifty::Foo and Mifty::Bar';

is +Template::Declare->show('hello'), 'hello from Foo',
    'Mifty::Foo should have precedence';

##############################################################################
# Import the Baz templates into Foo.
package Mifty::Foo;
import_templates Mifty::Baz under '/';

##############################################################################
package main;
ok !Template::Declare->init( dispatch_to => ['Mifty::Foo', 'Mifty::Bar'] ),
    'init to dispatch to Mifty::Foo and Mifty::Bar again';

is +Template::Declare->show('hello'), 'hello from Baz',
    'Mifty::Baz::hello should have replaced Mifty::Foo::hello';

# Now dispatch only to Bip and Foo.
ok !Template::Declare->init( dispatch_to => ['Mifty::Bip', 'Mifty::Foo'] ),
    'init to dispatch to Mifty::Bip and Mifty::Foo';

is +Template::Declare->show('hello'), 'hello from Bip',
    'Mifty::Bip should now have precedence';

##############################################################################
# Now try the same stuff with mixes.
##############################################################################
package Sifty::Foo;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Foo' };

##############################################################################
package Sifty::Bar;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Bar' };

##############################################################################
package Sifty::Baz;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Baz' };

##############################################################################
package Sifty::Bip;
use base qw/Template::Declare/;
use Template::Declare::Tags;
template hello => sub { outs 'hello from Bip' };

##############################################################################
# Import the Baz templates into Bar.
package Sifty::Bar;
mix Sifty::Baz under '/';

##############################################################################
package main;
ok !Template::Declare->init( dispatch_to => ['Sifty::Foo', 'Sifty::Bar'] ),
    'init to dispatch to Sifty::Foo and Sifty::Bar';

is +Template::Declare->show('hello'), 'hello from Foo',
    'Sifty::Foo should have precedence';

##############################################################################
# Import the Baz templates into Foo.
package Sifty::Foo;
import_templates Sifty::Baz under '/';

##############################################################################
package main;
ok !Template::Declare->init( dispatch_to => ['Sifty::Foo', 'Sifty::Bar'] ),
    'init to dispatch to Sifty::Foo and Sifty::Bar again';

is +Template::Declare->show('hello'), 'hello from Baz',
    'Sifty::Baz::hello should have replaced Sifty::Foo::hello';

# Now dispatch only to Bip and Foo.
ok !Template::Declare->init( dispatch_to => ['Sifty::Bip', 'Sifty::Foo'] ),
    'init to dispatch to Sifty::Bip and Sifty::Foo';

is +Template::Declare->show('hello'), 'hello from Bip',
    'Sifty::Bip should now have precedence';