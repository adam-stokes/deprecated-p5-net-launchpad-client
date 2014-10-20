package Net::Launchpad::Model;

# ABSTRACT: Query role

use Function::Parameters;
use Moose::Role;

method _model ($class, @args) {
    my $model = "Net::Launchpad::Model::$class";
    return use_package_optimistically($model)->new(@args);
}

method bug($id) {
    return $self->_model('Bug', $id);
}

method project($name) {
  return $self->_model('Project', $name);
}

method cve($sequence) {
  return $self->_mode('CVE', $sequence);
}

method person($name) {
  return $self->_model('Person', $name);
}



1;
