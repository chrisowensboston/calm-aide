# Class: aide::config
# Set up the config file that will be used to create or update the database
# This class also notifies the database update class (see init.pp)
# ===========================
class aide::config {
  include ::aide

  # localize for template
  $aide_path = $::aide::aide_path
  $mailto = $::aide::email

  # Set up the config file, but only if it isn't already there
  file { $::aide::conf_path:
    path    => $::aide::conf_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    replace => false,
    source  => 'puppet:///modules/aide/aide.conf',
  }

  # set up the run script
  file {"${::aide::conf_dir}/aide_check.sh":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0500',
    content => template('aide/aide_check.sh.erb'),
  }
}
