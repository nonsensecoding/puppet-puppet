# == Class: puppet
# #
# # provides basic settings for puppet self managing
# #
# # === Authors
# #
# # Maximilian Mayer <maximilian.mayer@sixt.de>
# #
# # === Copyright
# #
# # Copyright 2015 sixt AG
# #
#
class puppet (
$default_file_ensure	= 'file',
$default_file_owner		=	'root',
$default_file_group		= 'root',
$default_file_mode		= '0644',
$server            		= 'puppetmaster.tld',
$ca_server         		= 'puppetmaster.tld',
$digest_algorithm	 		= 'sha256',
$serverrole      	 		= 'false',
){

	File {
		ensure 	=> $default_file_ensure,
		owner 	=> $default_file_owner,
		group		=> $default_file_group,
		mode		=> $default_file_mode,
	}

  include puppet::agent
  case $serverrole {
    true:   	{include puppet::server}
    default:	{}
  }
}
