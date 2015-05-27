# == Class: puppet::server
#
# Full description of class puppetagent here.
#
# === Authors
#
# Maximilian Mayer <maximilian.mayer@sixt.de>
#
# === Copyright
#
# Copyright 2015 sixt AG
#

class puppet::puppetdb (
  $service_name               = 'puppetdb',
  $service_ensure             = 'running',
  $service_hasrestart         = 'true',
  $service_hasstatus          = 'true',
  $package_name               = 'puppetdb',
  $package_ensure             = 'installed',
  $package_terminus_name      = 'puppetdb-terminus',
  $package_terminus_ensure    = 'installed',
  $config_dir                 = '/etc/puppetdb',
  $confd_dir                  = "${config_dir}/conf.d",
  $confd_conf                 = 'conf.ini',
  $confd_conf_content         = 'puppet/conf.ini.epp',
  $confd_database             = 'database.ini',
  $confd_database_content     = 'puppet/database.ini.epp',
  $confd_jetty                = 'jetty.ini',
  $confd_jetty_content        = 'puppet/jetty.ini.epp',
  $confd_repl                 = 'repl.ini',
  $confd_repl_content         = 'puppet/repl.ini.epp',
  $server                     = 'puppetdb.tld',
  $port                       = '8080',
  $vardir                     = '/var/lib/puppetdb',
  $logging_config             = '/etc/puppetdb/logback.xml',
  $threads                    =  $::processorcount/2,
  $store_usage                = '10240',
  $temp_usage                 = '51200',
  $classname                  = 'org.hsqldb.jdbcDriver',
  $subprotocol                = 'hsqldb',
  $subname                    = 'file:/var/lib/puppetdb/db/db;hsqldb.tx=mvcc;sql.syntax_pgs=true',
  $username                   = 'UNSET',
  $password                   = 'UNSET',
  $gc_interval                = '60',
  $log_slow_statements        = '10',
  $node_ttl                   = '7d',
  $node_purge_ttl             = '14d',
  $jetty_host                 = '0.0.0.0',
  $jetty_port                 = '8080',
  $jetty_ssl_host             = '0.0.0.0',
  $jetty_ssl_port             = '8081',
  $ssl_key                    = '/etc/puppetdb/ssl/private.pem',
  $ssl_cert                   = '/etc/puppetdb/ssl/public.pem',
  $ssl_ca_cert                = '/etc/puppetdb/ssl/ca.pem',
  $repl_enabled               = 'false',
  $repl_type                  = 'nrepl',
  $repl_port                  = '8082',
  $file_owner                 = 'puppetdb',
  $file_group                 = 'puppetdb',
  $file_mode                  = '0640'
) {


  File {
    ensure  => 'present',
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
  }

  package {$package_name:
    ensure => $package_ensure,
  }

  package {$package_terminus_name:
    ensure => $package_terminus_ensure,
  }

  service {$service_name:
    ensure  => $service_ensure,
    require => Package[$package_name]
  }

  file {$config_dir:
    ensure  => 'directory',
    owner   => $puppet::default_owner,
    group   => $puppet::default_group,
    mode    => '0755',
  }

  file {$confd_dir:
    ensure  => 'directory',
    owner   => $file_owner,
    group   => $file_group,
    mode    => '0750',
    require => File[$config_dir],
  }

  file {$confd_conf:
    path    => "${confd_dir}/${confd_conf}",
    content => "${confd_dir}/${confd_conf_content}",
    require => File[$confd_dir],
    notify  => Service[$service_name]
  }

  file {$confd_database:
    path    => "${confd_dir}/${confd_database}",
    content => "${confd_dir}/${confd_database_content}",
    require => File[$confd_dir],
    notify  => Service[$service_name]
  }

  file {$confd_jetty:
    path    => "${confd_dir}/${confd_jetty}",
    content => "${confd_dir}/${confd_jetty_content}",
    require => File[$confd_dir],
    notify  => Service[$service_name]
  }

  file {$confd_repl:
    path    => "${confd_dir}/${confd_repl}",
    content => "${confd_dir}/${confd_repl_content}",
    require => File[$confd_dir],
    notify  => Service[$service_name]
  }

}
