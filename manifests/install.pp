# Class: aide::install
# ===========================
#
class aide::install () {
  include ::aide
    package { $::aide::package:
    ensure => $::aide::package_ensure,
    alias  => 'aide',
  }
}
