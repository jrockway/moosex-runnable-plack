use inc::Module::Install;
use strict;

name 'MooseX-Runnable-Plack';
all_from 'lib/MooseX/Runnable/Invocation/Scheme/Plack/Component/Role.pm';

requires 'MooseX::Runnable';
requires 'Plack';

test_requires 'LWP::Simple';
test_requires 'ok';

WriteAll;
