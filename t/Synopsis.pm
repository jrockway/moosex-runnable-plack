use MooseX::Declare;
use 5.010;

class t::Synopsis with (MooseX::Getopt, Plack::Component::Role) {
    has 'greeting' => (
        is      => 'ro',
        isa     => 'Str',
        default => 'Hello, world.',
    );

    # optional
    method run {
        say 'Starting the server';
    }

    method call {
        my $env = shift;

        return [ 200, [ content_type => 'text/plain' ], [ $self->greeting ] ];
    }
}
