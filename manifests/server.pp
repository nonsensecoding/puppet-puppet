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
  $package_name         = 'puppetserver',
  $package_ensure       = 'present',
  $routes_file          = '/etc/puppetlabs/puppet/routes.yaml',
  $routes_content       = 'puppet/routes.yaml.epp',
  $routes_terminus      = 'puppetdb',
  $routes_cache         = 'yaml',
  $autosign_file	= '/etc/puppetlabs/puppet/autosign.conf',
  $autosign_content	= 'puppet/autosign.conf.epp',
  $puppetdb_file	= '/etc/puppetlabs/puppet/puppetdb.conf',
  $puppetdb_content	= 'puppet/puppetdb.conf.epp',
  $vardir               = '/opt/puppetlabs/server/data/puppetserver',
  $logdir               = '/var/log/puppetlabs/puppetserver',
  $rundir               = '/var/run/puppetlabs/puppetserver',
  $pidfile              = '/var/run/puppetlabs/puppetserver/puppetserver.pid',
  $codedir              = '/etc/puppetlabs/code',
  $autosign             = true,
  $autosign_hostnames   = 'UNDEF',
  $storeconfigs         = true,
  $storeconfigs_backend = 'puppetdb',
  $reports              = 'store,puppetdb',
) {

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
}
