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
  $config_confd_dir                 = "$config_dir/conf.d",
  $confd_ca_conf                    = "$config_confd_dir/ca.conf",
  $confd_ca_conf_content            = 'puppet/ca.conf.epp',
  $confd_global_conf                = "$config_confd_dir/global.conf",
  $confd_global_conf_content        = 'puppet/global.conf.epp',
  $confd_puppetserver_conf          = "$config_confd_dir/puppetserver.conf",
  $confd_puppetserver_conf_content  = 'puppet/puppetserver.conf.epp',
  $confd_webroutes_conf             = "$config_confd_dir/web-routes.conf",
  $confd_webroutes_conf_content     = 'puppet/ca.conf.epp',
  $confd_webserver_conf             = "$config_confd_dir/webserver.conf",
  $confd_webserver_conf_content     = 'puppet/webserver.conf.epp',
  $vardir                           = '/opt/puppetlabs/server/data/puppetserver',
  $logdir                           = '/var/log/puppetlabs/puppetserver',
  $rundir                           = '/var/run/puppetlabs/puppetserver',
  $pidfile                          = '/var/run/puppetlabs/puppetserver/puppetserver.pid',
  $codedir                          = '/etc/puppetlabs/code',
  $autosign                         = true,
  $autosign_hostnames               = 'UNDEF',
  $storeconfigs                     = true,
  $storeconfigs_backend             = 'puppetdb',
  $reports                          = 'store,puppetdb',
  $master_conf_dir                  = '/etc/puppetlabs/puppet',
  $master_code_dir                  = '/etc/puppetlabs/code',
  $master_var_dir                   = '/opt/puppetlabs/server/data/puppetserver',
  $master_run_dir                   = '/var/run/puppetlabs/puppetserver',
  $master_log_dir                   = '/var/log/puppetlabs/puppetserver',
  $profiler                         = 'false',
  $webserver_ssl_host               = '0.0.0.0',
  $webserver_ssl_port               = '8140',
) {


  File {
    ensure  => 'present',
    owner   => $::puppet::default_owner,
    group   => $::puppet::default_group,
    mode    => $::puppet::default_mode,
  }

  package { $package_name:
    ensure => $package_ensure,
  }

  file { 'routes.yaml':
    path    => $routes_file,
    content => epp($routes_content),
  }

  if $autosign == 'true' {
    file { 'autosign.conf':
      path    => $autosign_file,
      content => epp($autosign_content),
    }
  }

  if $storeconfigs_backend == 'puppetdb' {
    file {'puppetdb.conf':
      path    => $puppetdb_file,
      content => epp($puppetdb_content),
    }
  }

  file {$config_dir:
    ensure  => directory,
    mode    =>  '0755',
  }

  file {$config_confd_dir:
    ensure    => directory,
    mode      =>  '0755',
    requires  => File[$config_dir]
  }

  file {'ca.conf':
    path      => $confd_ca_conf,
    content   => epp($confd_ca_conf_content),
    requires  => File[$config_confd_dir],
  }

  file {'global.conf':
    path      => $confd_global_conf,
    content   => epp($confd_global_conf_content),
    requires  => File[$config_confd_dir],
  }

  file {'puppetserver.conf':
    path      => $confd_puppetserver_conf,
    content   => epp($confd_puppetserver_conf_content),
    requires  => File[$config_confd_dir],
  }

  file {'web-routes.conf':
    path      => $confd_webroutes_conf,
    content   => epp($confd_webroutes_conf_content),
    requires  => File[$config_confd_dir],
  }

  file {'webserver.conf':
    path      => $confd_webserver_conf,
    content   => epp($confd_webserver_conf_content),
    requires  => File[$config_confd_dir],
  }

}
