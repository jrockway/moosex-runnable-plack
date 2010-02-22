package MooseX::Runnable::Invocation::Scheme::Plack::Component::Role;
use Moose::Role;
use namespace::autoclean;

use Plack::Runner;

around start_application => sub {
    my ($orig, $self, $instance, @args) = @_;
    # "run" in the runnable class basically becomes a BUILD block.
    # could be useful...
    $self->$orig( $instance, @args );

    Plack::Runner->run( '--app' => $instance->to_app, @args );
};

1;
