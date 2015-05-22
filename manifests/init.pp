# == Class: puppet
#
# provides basic settings for puppet self managing
#
# === Authors
#
# Maximilian Mayer <maximilian.mayer@sixt.de>
#
# === Copyright
#
# Copyright 2015 sixt AG
#
class puppet (
  $serverrole          = 'false',
  $default_file_ensure = 'file',
  $default_file_owner  = 'root',
  $default_file_group  = 'root',
  $default_file_mode   = '0644',
  $server              = 'puppetmaster.tld',
  $ca_server           = 'puppetmaster.tld',
  $digest_algorithm    = 'sha256',
  $archive_files       = true,
) {

  case $serverrole {
    'true': {
      require '::puppet::server'
      include ::puppet::agent
    }
    default: {
      include ::puppet::agent
    }
  }
}
