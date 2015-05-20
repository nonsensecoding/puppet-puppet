# == Class: cron
#
# Manages Cron daemon and its directories to place cronjobs either manually or via puppet
#
#
# Maximilian Mayer <maximilian.mayer@sixt.de>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class cron (
$cron_service_name 				= 'crond',
$cron_file_default_owner	= 'root',
$cron_file_default_group	= 'root',
$cron_file_default_mode		= '0644',
$cron_dir_generic					= '/etc/cron.d',
$cron_dir_hourly					= '/etc/cron.hourly',
$cron_dir_daily						= '/etc/cron.daily',
$cron_dir_weekly					= '/etc/cron.weekly',
$cron_dir_monthly					= '/etc/cron.monthly',
) {

File {
	ensure 	=> file,
	owner 	=> $cron_file_default_owner,
	group 	=> $cron_file_default_group,
	mode 		=> $cron_file_default_mode,
}

service {$cron_service_name:
	ensure      => running,
	enable      => true,
	hasrestart 	=> true,
	hasstatus		=> true,
}

file {$cron_dir_generic:
	ensure	=> directory,
	mode 		=> '0755',
}

file {$cron_dir_hourly:
	ensure	=> directory,
	mode 		=> '0755',
}

file {$cron_dir_daily:
	ensure	=> directory,
	mode 		=> '0755',
}

file {$cron_dir_weekly:
	ensure	=> directory,
	mode 		=> '0755',
}

file {$cron_dir_monthly:
	ensure	=> directory,
	mode 		=> '0755',
}

}
