use strict;
use warnings;
use Test::More;

use ok 't::Synopsis';

use MooseX::Runnable::Run;
use LWP::Simple qw(get);

my $pid = fork;
unless ($pid) {
    # child

    # XXX: there is an annoying bug in MooseX::Getopt where '--port' and
    # '--host' don't get passed through; instead the program just dies.
    # will fix later.
    run_application 't::Synopsis', (
        '--greeting', 'OH HAI',
    );
    exit;
}

ok $pid, 'spawned child ok';
sleep 1;

my $result = get 'http://127.0.0.1:5000/';
is $result, 'OH HAI', 'got an answer from the web server';


kill 9, $pid;
waitpid -1, $pid;

pass 'child aparently exited ok';

done_testing;
