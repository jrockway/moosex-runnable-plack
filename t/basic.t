use strict;
use warnings;
use Test::More;

use MooseX::Runnable::Run;
use LWP::Simple qw(get);

use ok 't::Class';

my $pid = fork;
unless ($pid) {
    # child
    run_application 't::Class', ( '--host', '127.0.0.1', '--port', '9191' );
    exit;
}

ok $pid, 'spawned child ok';
sleep 1;

my $result = get 'http://127.0.0.1:9191/';
is $result, 'OK', 'got an answer from the web server';


kill 9, $pid;
waitpid -1, $pid;

pass 'child aparently exited ok';

done_testing;
