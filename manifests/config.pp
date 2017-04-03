# Class: aide::config
# Set up the config file that will be used to create or update the database
# This class also notifies the database update class (see init.pp)
# ===========================
class aide::config {
  include ::aide

  # localize for template
  $aide_path = $::aide::aide_path
  $mailto = $::aide::email
  $db_path = $::aide::db_path
  $db_new_path = $::aide::db_new_path
  $log_path = "${::aide::log_dir}/aide.log"

  # Set up the config file, but only if it isn't already there
  file { $::aide::conf_path:
    path    => $::aide::conf_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    replace => false,
    content => template("${module_name}/aide.conf.erb"),
  }

  # Set up the log directory
  file {$::aide::log_dir:
    ensure  => directory,
    path    => $::aide::log_dir,
    recurse => false,
    purge   => false,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
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
