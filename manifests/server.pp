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
  $vardir               = '/opt/puppetlabs/server/data/puppetserver',
  $logdir               = '/var/log/puppetlabs/puppetserver',
  $rundir               = '/var/run/puppetlabs/puppetserver',
  $pidfile              = '/var/run/puppetlabs/puppetserver/puppetserver.pid',
  $codedir              = '/etc/puppetlabs/code',
  $autosign             = true,
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
}
