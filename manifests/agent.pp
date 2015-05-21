# == Class: puppet::agent
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
class puppet::agent (
  $agent_config_file            = '/etc/puppetlabs/puppet/puppet.conf',
  $agent_config_content         = 'puppet/puppet.conf.epp',
  $agent_package_name           = 'puppet-agent',
  $agent_package_ensure         = 'installed',
  $agent_cron_name              = 'cron-puppetagent',
  $agent_cron_user              = 'root',
  $agent_cron_minute            = [fqdn_rand(15), fqdn_rand(15)+30],
  $agent_cron_day               = '*',
  $agent_cron_hour              = '*',
  $agent_cron_command           = '/usr/local/bin/puppet agent --o --no-daemonize',
  $symlink_puppet         	= '/usr/local/bin/puppet',
  $symlink_puppet_target  	= '/opt/puppetlabs/bin/puppet',
  $symlink_facter         	= '/usr/local/bin/facter',
  $symlink_facter_target  	= '/opt/puppetlabs/bin/facter',
  $symlink_cfacter        	= '/usr/local/bin/cfacter',
  $symlink_cfacter_target 	= '/opt/puppetlabs/bin/cfacter',
  $symlink_hiera          	= '/usr/local/bin/hiera',
  $symlink_hiera_target   	= '/opt/puppetlabs/bin/hiera',
  $symlink_mco            	= '/usr/local/bin/mco',
  $symlink_mco_target     	= '/opt/puppetlabs/bin/mco',
  $report                       = 'true',
  $classfile                    = '$vardir/classes.txt',
  $graph                        = 'false',
  $pluginsync                   = 'true',
  $waitforcert                  = '120',
)
{

  include cron

  package { $agent_package_name:
    ensure => $agent_package_ensure,
  }

  if $::puppet::serverole == 'true' {
    require '::puppet::server'
  }

  file { $agent_config_file:
    ensure  => present,
    content => epp($agent_config_content),
    require => Package[$agent_package_name],
  }

  cron { $agent_cron_name:
    ensure   => present,
    user     => $agent_cron_user,
    minute   => $cron_minute,
    hour     => $agent_cron_hour,
    monthday => $agent_cron_day,
    command  => $agent_cron_command,
    require  => [ Package[$agent_package_name], Service['crond'] ],
  }

  file { 'symlink_puppet':
    ensure  => link,
    path    => $symlink_puppet,
    target  => $symlink_puppet_target,
    require => Package[$agent_package_name],
  }

  file { 'symlink_hiera':
    ensure  => link,
    path    => $symlink_hiera,
    target  => $symlink_hiera_target,
    require => Package[$agent_package_name],
  }

  file {'symlink_facter':
    ensure  => link,
    path    => $symlink_facter,
    target  => $symlink_facter_target,
    require => Package[$agent_package_name],
  }

  file { 'symlink_cfacter':
    ensure  => link,
    path    => $symlink_cfacter,
    target  => $symlink_cfacter_target,
    require => Package[$agent_package_name],
  }

  file { 'symlink_mco':
    ensure  => link,
    path    => $symlink_mco,
    target  => $symlink_mco_target,
    require => Package[$agent_package_name],
  }
}
