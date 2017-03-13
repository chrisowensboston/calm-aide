node default {
  class { '::aide':
    email  => 'root@localhost',
    hour   => 3,
    minute => 0,
}
  aide::rule { 'etc rule':
    content => '/etc p+sha256',
    order   => 1,
  }
  aide::rule { 'boot rule':
    content => '/boot p+sha256',
    order   => 2,
  }
}
