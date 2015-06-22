# == Class: puppet
#
# provides basic settings for puppet self managing
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
class puppet (
  $serverrole          = 'false',
  $default_file_ensure = 'file',
  $default_file_owner  = 'root',
  $default_file_group  = 'root',
  $default_file_mode   = '0644',
  $server              = 'puppetmaster.tld',
  $ca_server           = 'puppetmaster.tld',
  $puppetdb_server     = 'puppetdb.tld',
  $puppetdb_port       = '8081',
  $digest_algorithm    = 'sha256',
  $archive_files       = 'true',
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
