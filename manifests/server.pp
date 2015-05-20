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
$server_package_name 		= 'puppetserver',
$server_routes_file 		= '/etc/puppetlabs/puppet/routes.yaml'
$server_routes_content	= epp(puppet/routes.yaml.epp),
) {

	package {$server_package_name: 
		ensure	=> $server_package_ensure
		name 		=> $osfamily ? {
		RedHat	=> 'puppetserver',
		default	=> 'puppetserver',
		},
	}

	file {'routes.yaml'
		path 		=> $server_routes_file,
		content => $server_routes_content,
	}	

}
