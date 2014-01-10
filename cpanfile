requires 'Class::Load';
requires 'Mojo::Base';
requires 'Mojo::JSON';
requires 'URI';
requires 'URI::Encode';
requires 'URI::QueryParam';

on test => sub {
    requires 'Test::More';
};
