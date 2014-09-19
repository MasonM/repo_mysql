# About
Installs the [MySQL community server Yum repository](http://dev.mysql.com/downloads/repo/)
on Redhat-based (RHEL, CentOS, Fedora) operating systems.

# Usage

To use the repository for the latest release series, just include "repo\_mysql":
```puppet
include repo_mysql
```

To select a release series (e.g. "5.6"), set the "release\_series" parameter:
```puppet
class { "repo_mysql":
    release_series => "5.6",
}
```

To install the MySQL server and client from this repo, use the package names `mysql-community-server`
and `mysql-community-client`, respectively. For example:

```puppet
package { 'mysql-community-server':
    ensure => 'latest',
}
```

# License
Apache Software License 2.0
