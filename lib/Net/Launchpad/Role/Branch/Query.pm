package Net::Launchpad::Role::Branch::Query;

# ABSTRACT: Branch query role

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Query';

has _path => (is => 'ro', default => 'branches');

method __get ($params) {
    return $self->resource($self->_path, $params);
}

method get_by_unique_name (Str $name) {
    my $params = {
        'ws.op'     => 'getByUniqueName',
        unique_name => $name
    };
    return $self->__get($params);
}

method get_by_url (Str $url) {
    my $params = {
        'ws.op' => 'getByUrl',
        url     => $url
    };
    return $self->__get($params);
}

method get_by_urls (ArrayRef $urls) {
    my $params = {
        'ws.op' => 'getByUrls',
        urls    => join(',', @{$urls})
    };
    return $self->__get($params);
}


1;
