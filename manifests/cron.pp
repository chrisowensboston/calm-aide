# Configures cron 
class aide::cron {
  include ::aide
  cron { 'aide':
    command => "${::aide::conf_dir}/aide_check.sh",
    user    => 'root',
    hour    => $::aide::hour,
    minute  => $::aide::minute,
  }
}
