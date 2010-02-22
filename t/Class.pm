package t::Class;
use Moose;
use namespace::autoclean;
with 'MooseX::Runnable', 'Plack::Component::Role';

sub call {
    my $env = shift;
    return [ 200, [ content_type => 'text/plain' ], [ 'OK' ] ];
}

1;
