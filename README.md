# NAME

Net::Launchpad::Client - Launchpad.net Client routines

# SYNOPSIS

    use Net::Launchpad::Client;
    my $lp = Net::Launchpad::Client->new(
        access_token        => '32432432432',
        access_token_secret => '32432432423432423432423232',
        consumer_key        => 'a-named-key'
    );

# ATTRIBUTES

## __json__

A [Mojo::JSON](https://metacpan.org/pod/Mojo::JSON) object.

# ATTRIBUTES

## consumer\_key

## access\_token

## access\_token\_secret

## json

## ua

## staging

## nonce

## authorization\_header

Authorization string as described at [https://help.launchpad.net/API/SigningRequests](https://help.launchpad.net/API/SigningRequests) __Using the credentials__

# METHODS

## __api\_url__

Launchpad API host

## __get__

Performs a HTTP GET request for a particular resource.

## __post__

Performs a HTTP POST request for a resource.

# AUTHOR

Adam Stokes, `<adamjs at cpan.org>`

# BUGS

Report bugs to https://github.com/battlemidget/Net-Launchpad-Client/issues.

# DEVELOPMENT

## Repository

    http://github.com/battlemidget/Net-Launchpad-Client

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Launchpad::Client

# SEE ALSO

- [https://launchpad.net/launchpadlib](https://launchpad.net/launchpadlib), "Python implementation"

# COPYRIGHT

Copyright 2013-2014 Adam Stokes

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
