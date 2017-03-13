# Class: aide
# ===========================
#
class aide (
  String $package              = 'aide',
  String $package_version      = 'latest',
  Integer[0,23] $hour          = 1,
  Integer[0,59] $minute        = 0,
  String $email                = 'root@localhost',
  Stdlib::Absolutepath $db_dir = '/var/lib/aide',
) {

  case $::osfamily {
    'Debian': {
      $aide_path = '/usr/bin/aide'
      $conf_dir = '/etc/aide'
      $mail_path = '/usr/bin/mail'
    }
    'Redhat': {
      $aide_path = '/usr/sbin/aide'
      $conf_dir = '/etc'
      $mail_path = '/bin/mail'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  $db_path      = "${db_dir}/aide.db"
  $db_temp_path = "${db_dir}/aide.db.new"
  $conf_path    = "${conf_dir}/aide.conf"

  contain '::aide::install'
  contain '::aide::config'
  contain '::aide::installdb'
  contain '::aide::cron'

  Class[::aide::install] ->
  Class[::aide::config] ~>
  Class[::aide::installdb] ->
  Class[::aide::cron]

}
