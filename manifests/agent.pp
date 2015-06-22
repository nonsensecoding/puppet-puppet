# == Class: puppet::agent
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
class puppet::agent (
  $config_file            = '/etc/puppetlabs/puppet/puppet.conf',
  $config_content         = 'puppet/puppet.conf.epp',
  $symlink_puppet         = '/usr/local/bin/puppet',
  $symlink_puppet_target  = '/opt/puppetlabs/bin/puppet',
  $symlink_facter         = '/usr/local/bin/facter',
  $symlink_facter_target  = '/opt/puppetlabs/bin/facter',
  $symlink_cfacter        = '/usr/local/bin/cfacter',
  $symlink_cfacter_target = '/opt/puppetlabs/bin/cfacter',
  $symlink_hiera          = '/usr/local/bin/hiera',
  $symlink_hiera_target   = '/opt/puppetlabs/bin/hiera',
  $symlink_mco            = '/usr/local/bin/mco',
  $symlink_mco_target     = '/opt/puppetlabs/bin/mco',
  $package_name           = 'puppet-agent',
  $package_ensure         = 'installed',
  $cron_name              = 'cron-puppetagent',
  $cron_user              = 'root',
  $cron_minute            = 'UNSET',
  $runs_per_hour          = '4',
  $cron_day               = '*',
  $cron_hour              = '*',
  $cron_command           = '/usr/local/bin/puppet agent --onetime --no-daemonize',
  $report                 = true,
  $classfile              = '$vardir/classes.txt',
  $graph                  = false,
  $pluginsync             = true,
  $waitforcert            = '120',
<<<<<<< HEAD
  $logdest                = 'console',
  $clientbucket_dir       = '/opt/puppetlabs/puppet/cache/clientbucket',
=======
>>>>>>> b942ea5ad7005048530a996fb0c25d02c482fd43
) {

  include cron

  if $cron_minute == 'UNSET' {
    case $runs_per_hour {
      '1': {
        $cron_real_min = fqdn_rand(60)
      }
      '2': {
        $cron_real_min = [fqdn_rand(30), fqdn_rand(30)+30 ]
      }
      '3': {
        $cron_real_min = [fqdn_rand(20), fqdn_rand(20)+20, fqdn_rand(20)+40 ]
      }
      '4': {
        $cron_real_min = [fqdn_rand(15), fqdn_rand(15)+15, fqdn_rand(15)+30, fqdn_rand(15)+45 ]
      }
      default: {
        fail('Please, specifiy a cron_minute or set runs_per_hour to a valid value, supported values are 1 - 4')
      }
    }
  }
  else {
    $cron_real_min = $cron_minute
  }

  package { $package_name:
    ensure => $package_ensure,
  }

  if $::puppet::serverole == 'true' {
    require '::puppet::server'
  }

  file { $config_file:
    ensure  => present,
    content => epp($config_content),
    require => Package[$package_name],
  }

  cron { $cron_name:
    ensure   => present,
    user     => $cron_user,
    minute   => $cron_real_min,
    hour     => $cron_hour,
    monthday => $cron_day,
    command  => $cron_command,
    require  => [ Package[$package_name], Service['crond'] ],
  }

  file { 'symlink_puppet':
    ensure  => link,
    path    => $symlink_puppet,
    target  => $symlink_puppet_target,
    require => Package[$package_name],
  }

  file { 'symlink_hiera':
    ensure  => link,
    path    => $symlink_hiera,
    target  => $symlink_hiera_target,
    require => Package[$package_name],
  }

  file {'symlink_facter':
    ensure  => link,
    path    => $symlink_facter,
    target  => $symlink_facter_target,
    require => Package[$package_name],
  }

  file { 'symlink_cfacter':
    ensure  => link,
    path    => $symlink_cfacter,
    target  => $symlink_cfacter_target,
    require => Package[$package_name],
  }

  file { 'symlink_mco':
    ensure  => link,
    path    => $symlink_mco,
    target  => $symlink_mco_target,
    require => Package[$package_name],
  }
}
