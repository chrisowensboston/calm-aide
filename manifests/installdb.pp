# Initialises new database and copies it to the correct location
# aide::config notifies this class, causing the database to be
# refreshed whenever a new configuration file is processed

class aide::installdb {
  include ::aide

  exec { 'aide_init':
    command     => "${::aide::aide_path} --init --config ${::aide::conf_path}",
    user        => 'root',
    refreshonly => true,
  }

  file {$::aide::db_path:
    ensure    => 'file',
    backup    => '.bak',
    owner     => 'root',
    group     => 'root',
    mode      => '0400',
    source    => "file:${::aide::db_temp_path}",
    subscribe => Exec['aide_init'],
    }
}
