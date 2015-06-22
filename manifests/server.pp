# == Class: puppet::server
#
# Full description of class puppetagent here.
#
# === Authors
#
<<<<<<< HEAD
# Maximilian Mayer <maximilian.mayer@sixt.com>
=======
# Maximilian Mayer <maximilian.mayer@sixt.de>
>>>>>>> b942ea5ad7005048530a996fb0c25d02c482fd43
#
# === Copyright
#
# Copyright 2015 sixt AG
#
class puppet::server (
  $package_name                     = 'puppetserver',
  $package_ensure                   = 'present',
  $routes_file                      = '/etc/puppetlabs/puppet/routes.yaml',
  $routes_content                   = 'puppet/routes.yaml.epp',
  $routes_terminus                  = 'puppetdb',
  $routes_cache                     = 'yaml',
  $autosign_file                    = '/etc/puppetlabs/puppet/autosign.conf',
  $autosign_content                 = 'puppet/autosign.conf.epp',
  $puppetdb_file                    = '/etc/puppetlabs/puppet/puppetdb.conf',
  $puppetdb_content                 = 'puppet/puppetdb.conf.epp',
  $config_dir                       = '/etc/puppetlabs/puppetserver',
  $config_confd_dir                 = '/etc/puppetlabs/puppetserver/conf.d',
  $confd_ca_conf                    = 'ca.conf',
  $confd_ca_conf_content            = 'puppet/ca.conf.epp',
  $confd_global_conf                = 'global.conf',
  $confd_global_conf_content        = 'puppet/global.conf.epp',
  $confd_puppetserver_conf          = 'puppetserver.conf',
  $confd_puppetserver_conf_content  = 'puppet/puppetserver.conf.epp',
  $confd_webroutes_conf             = 'web-routes.conf',
  $confd_webroutes_conf_content     = 'puppet/webroutes.conf.epp',
  $confd_webserver_conf             = 'webserver.conf',
  $confd_webserver_conf_content     = 'puppet/webserver.conf.epp',
  $vardir                           = '/opt/puppetlabs/server/data/puppetserver',
  $logdir                           = '/var/log/puppetlabs/puppetserver',
  $rundir                           = '/var/run/puppetlabs/puppetserver',
<<<<<<< HEAD
  $bucketdir                        = 'default',
=======
>>>>>>> b942ea5ad7005048530a996fb0c25d02c482fd43
  $pidfile                          = '/var/run/puppetlabs/puppetserver/puppetserver.pid',
  $codedir                          = '/etc/puppetlabs/code',
  $autosign                         = true,
  $autosign_hostnames               = 'UNDEF',
  $storeconfigs                     = true,
  $storeconfigs_backend             = 'puppetdb',
  $reports                          = 'store,puppetdb',
<<<<<<< HEAD
  $profiler                         = 'false',
  $webserver_ssl_host               = '0.0.0.0',
  $webserver_ssl_port               = '8140',
  $sysconfig_file                   = '/etc/sysconfig/puppetserver',
  $sysconfig_content                = 'puppet/sysconfig.epp', ## currently working only for el5/el6 systems
  $runas_user                       = 'puppet',
  $runas_group                      = 'puppet',
=======
  $master_conf_dir                  = '/etc/puppetlabs/puppet',
  $master_code_dir                  = '/etc/puppetlabs/code',
  $master_var_dir                   = '/opt/puppetlabs/server/data/puppetserver',
  $master_run_dir                   = '/var/run/puppetlabs/puppetserver',
  $master_log_dir                   = '/var/log/puppetlabs/puppetserver',
  $profiler                         = 'false',
  $webserver_ssl_host               = '0.0.0.0',
  $webserver_ssl_port               = '8140',
>>>>>>> b942ea5ad7005048530a996fb0c25d02c482fd43
) {


  File {
    ensure  => 'present',
    owner   => $::puppet::default_owner,
    group   => $::puppet::default_group,
    mode    => $::puppet::default_mode,
  }

  package { $package_name:
    ensure => $package_ensure,
    notify    => Service['puppetserver'],
  }

  service {'puppetserver':
    ensure     => $service_ensure,
    hasrestart => 'true',
    hasstatus  => 'true',
  }

  file { 'routes.yaml':
    path    => $routes_file,
    content => epp($routes_content),
    notify    => Service['puppetserver'],
  }

  if $autosign == 'true' {
    file { 'autosign.conf':
      path    => $autosign_file,
      content => epp($autosign_content),
      notify    => Service['puppetserver'],
    }
  }

  if $storeconfigs_backend == 'puppetdb' {
    file {'puppetdb.conf':
      path    => $puppetdb_file,
      content => epp($puppetdb_content),
      notify    => Service['puppetserver'],
    }
  }

<<<<<<< HEAD
  file { 'sysconfig_puppetserver':
    path    => $sysconfig_file,
    content => epp($sysconfig_content),
    notify    => Service['puppetserver'],
  }

  file {$codedir:
    ensure  => directory,
    mode    => '0755',
    owner   => $runas_user,
    group   => $runas_group,
  }

  file {$config_dir:
    ensure  => directory,
    mode    =>  '0755',
    owner   => $runas_user,
    group   => $runas_group,
=======
  file {$config_dir:
    ensure  => directory,
    mode    =>  '0755',
>>>>>>> b942ea5ad7005048530a996fb0c25d02c482fd43
  }

  file {$config_confd_dir:
    ensure  => directory,
    mode    =>  '0755',
<<<<<<< HEAD
    owner   => $runas_user,
    group   => $runas_group,
=======
>>>>>>> b942ea5ad7005048530a996fb0c25d02c482fd43
    require => File[$config_dir]
  }

  file {'ca.conf':
    path     => "${config_confd_dir}/${confd_ca_conf}",
    content  => epp($confd_ca_conf_content),
    require  => File[$config_confd_dir],
    notify    => Service['puppetserver'],
  }

  file {'global.conf':
    path     => "${config_confd_dir}/${confd_global_conf}",
    content  => epp($confd_global_conf_content),
    require  => File[$config_confd_dir],
    notify    => Service['puppetserver'],
  }

  file {'puppetserver.conf':
    path     => "${config_confd_dir}/${confd_puppetserver_conf}",
    content  => epp($confd_puppetserver_conf_content),
    require  => File[$config_confd_dir],
    notify    => Service['puppetserver'],
  }

  file {'web-routes.conf':
    path     => "${config_confd_dir}/${confd_webroutes_conf}",
    content  => epp($confd_webroutes_conf_content),
    require  => File[$config_confd_dir],
    notify    => Service['puppetserver'],
  }

  file {'webserver.conf':
    path      => "${config_confd_dir}/${confd_webserver_conf}",
    content   => epp($confd_webserver_conf_content),
    require   => File[$config_confd_dir],
    notify    => Service['puppetserver'],
  }

}
