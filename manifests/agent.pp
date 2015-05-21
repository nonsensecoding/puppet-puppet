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
  $agent_symlink_puppet         = '/usr/local/bin/puppet',
  $agent_symlink_puppet_target  = '/opt/puppetlabs/bin/puppet',
  $agent_symlink_facter         = '/usr/local/bin/facter',
  $agent_symlink_facter_target  = '/opt/puppetlabs/bin/facter',
  $agent_symlink_cfacter        = '/usr/local/bin/cfacter',
  $agent_symlink_cfacter_target = '/opt/puppetlabs/bin/cfacter',
  $agent_symlink_hiera          = '/usr/local/bin/hiera',
  $agent_symlink_hiera_target   = '/opt/puppetlabs/bin/hiera',
  $agent_symlink_mco            = '/usr/local/bin/mco',
  $agent_symlink_mco_target     = '/opt/puppetlabs/bin/mco',
  $agent_package_name           = 'puppet-agent',
  $agent_package_ensure         = 'installed',
  $agent_cron_name              = 'cron-puppetagent',
  $agent_cron_user              = 'root',
  $agent_cron_minute            = 'UNSET',
  $agent_cron_day               = '*',
  $agent_cron_hour              = '*',
  $agent_cron_command           = '/usr/local/bin/puppet agent -o --no-daemonize',
  $report                       = true,
  $classfile                    = '$vardir/classes.txt'
  $graph                        = false,
  $pluginsync                   = true,
  $waitforcert                  = '120',
) {

  include cron

  if $agent_cron_minute == 'UNSET' {
    $cron_minute = [fqdn_rand(15), fqdn_rand(15)+30 ]
  }
  else {
    $cron_minute = $agent_cron_minute
  }

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
    ensure  	=> present,
    user    	=> $agent_cron_user,
		minute 		=> $cron_minute,
		hour 			=> $agent_cron_hour,
		monthday	=> $agent_cron_day,
		command 	=> $agent_cron_command,
    require 	=> [ Package[$agent_package_name],
									Service['crond'] ],
  }

  file { 'agent_symlink_puppet':
    ensure  => link,
    path		=> $agent_symlink_puppet,
    target  => $agent_symlink_puppet_target,
    require => Package[$agent_package_name],
  }

  file { 'agent_symlink_hiera':
    ensure 	=> link,
    path		=> $agent_symlink_hiera,
    target 	=> $agent_symlink_hiera_target,
    require	=> Package[$agent_package_name],
  }

  file {'agent_symlink_facter':
    ensure  => link,
		path 		=> $agent_symlink_facter,
    target  => $agent_symlink_facter_target,
    require => Package[$agent_package_name],
  }

  file { 'agent_symlink_cfacter':
    ensure  	=> link,
		path 			=> $agent_symlink_cfacter,
    target  	=> $agent_symlink_cfacter_target,
    require  	=> Package[$agent_package_name],
  }

  file { 'agent_symlink_mco':
    ensure  => link,
		path		=> $agent_symlink_mco,
   	target  => $agent_symlink_mco_target,
    require => Package[$agent_package_name],
  }
}
