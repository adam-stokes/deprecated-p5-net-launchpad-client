requires 'Class::Load';
requires 'Mojo::Base';
requires 'Mojo::JSON';
requires 'Mojo::Parameters';
requires 'Mojo::UserAgent';

on configure => sub {
    requires 'Module::Build::Tiny', '0.030';
    requires 'perl', '5.006';
};

on test => sub {
    requires 'Test::More';
};
