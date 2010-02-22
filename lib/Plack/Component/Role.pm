package Plack::Component::Role;
use Moose::Role;
use namespace::autoclean;

use Plack::Component;

with 'MooseX::Runnable';

requires 'call';

sub prepare_app {}
sub to_app { goto &Plack::Component::to_app }

# run is not too relevant; the server runs the "app", and "call" is
# really "running the class".
sub run { $_[0]->prepare_app; return 0 }

1;

__END__

=head1 NAME

Plack::Component::Role - Moose role indicating that the consuming class is a Plack app

=head1 SYNOPSIS

Write a web app:

    class MyApp with (MooseX::Getopt, Plack::Component::Role) {
        has 'greeting' => (
            is      => 'ro',
            isa     => 'Str',
            default => 'Hello, world.',
        );

        # optional
        method run {
            say 'Starting the server';
        }

        method call(HashRef $env) {
            return [ 200, [ content_type => 'text/plain' ], [ $self->greeting ] ];
        }
    }

And run it:

   $ mx-run MyApp --greeting "OH HAI" --port 8080 &
     Server started at http://localhost:8080/
   $ curl http://localhost:8080/
     OH HAI
   $

=head1 DESCRIPTION

This module lets you write a Plack component that can be run the
normal way (C<< App->new( ... )->to_app >>), or via
L<MooseX::Runnable|MooseX::Runnable>.  When you use
C<MooseX::Runnable>, everything works like a normal runnable class,
except that your "call" method becomes a web app.  You can use
MooseX::Getopt and any MooseX::Runnable plugins, and you can pass args
to plackup by appending them to the normal command-line, like
C<< --port >> above.
