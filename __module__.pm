package Rex::Gentoo::Kernel;

use Rex -base;
use Rex::Template::TT;

use Term::ANSIColor;

desc 'Compile and install Gentoo kernel';


task 'setup', sub {
  pkg "gentoo-sources",
    ensure  => "present";

  file "/usr/src/linux/.config",
    content => template("templates/config.tt"),
    on_change => sub {
      run "make",                 cwd => "/usr/src/linux", auto_die => TRUE;
      run "make modules_install", cwd => "/usr/src/linux", auto_die => TRUE;
      run "make install",         cwd => "/usr/src/linux", auto_die => TRUE;
    };
};

task 'upgrade', sub {
  # TODO
};


1;

=pod

=head1 NAME

$::module_name - {{ SHORT DESCRIPTION }}

=head1 DESCRIPTION

{{ LONG DESCRIPTION }}

=head1 USAGE

{{ USAGE DESCRIPTION }}

 include qw/Rex::Gentoo::Install/;

 task yourtask => sub {
    Rex::Gentoo::Install::example();
 };

=head1 TASKS

=over 4

=item example

This is an example Task. This task just output's the uptime of the system.

=back

=cut
