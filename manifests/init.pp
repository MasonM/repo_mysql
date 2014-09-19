# Installs Yum repo for Mysql: http://dev.mysql.com/downloads/repo/
class repo_mysql ($release_series = undef) {
  $version_string = $release_series ? {
    undef   => 'mysql-community',
    default => "mysql-${release_series}-community",
  }

  case $::operatingsystem {
    centos, redhat, amazon: {
      $baseurl = "http://repo.mysql.com/yum/${version_string}/el/${::os_maj_version}"
    }
    fedora: {
      $baseurl = "http://repo.mysql.com/yum/${version_string}/fc/\$releasever"
    }
    default: {
      fail('ERROR: Your operating system is not supported for the MySQL repository')
    }
  }

  Yumrepo {
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql',
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/repo_mysql/RPM-GPG-KEY-mysql',
  }
  ->
  yumrepo {
    $version_string:
      baseurl  => "${baseurl}/\$basearch/",
      descr    => "MySQL ${release_series} Community Server";
    "${version_string}-src":
      baseurl  => "${baseurl}/SRPMS/",
      descr    => "MySQL ${release_series} Community Server - Source";
  }
}
