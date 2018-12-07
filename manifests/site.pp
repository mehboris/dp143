
node default{
}
node db-master{
	notice("Loading mysqlmaster")
 		class { 'mysql::server':
    			restart          => true,
    			root_password    => 'changeme',
    			override_options => {
      						'mysqld' => {
        							'bind_address'                   => '0.0.0.0',
        							'server-id'                      => '1',
        							'binlog-format'                  => 'mixed',
        							'log-bin'                        => 'mysql-bin',
        							'datadir'                        => '/var/lib/mysql',
        							'innodb_flush_log_at_trx_commit' => '1',
        							'sync_binlog'                    => '1',
        							'binlog-do-db'                   => ['demo'],
     							 	},
   	 					}
  			}->

  		mysql_user { 'slave_user@%':
    				ensure        => 'present',
    				password_hash => mysql_password('changeme'),
  			}->

  		mysql_grant { 'slave_user@%/*.*':
    				ensure     => 'present',
    				privileges => ['REPLICATION SLAVE'],
    				table      => '*.*',
   				user       => 'slave_user@%',
  			}->

  		mysql::db { 'demo':
   				 ensure   => 'present',
    				 user     => 'demo',
    				 password => 'changeme',
    				 host     => '%',
    				 grant    => ['all'],
			}->
		exec { 'active master':
 				cwd => '/etc/puppetlabs/code/environments/production/',
 				command => '/usr/bin/bash upmaster.sh',
 				creates => '/etc/puppetlabs/code/environments/production/status.txt',
			}
		}
node db-slave{
	notice("Loading mysqlslave")

  class { 'mysql::server':
    restart          => true,
    root_password    => 'changeme',
    override_options => {
      'mysqld' => {
        'bind_address' => '0.0.0.0',
        'server-id'         => '2',
        'binlog-format'     => 'mixed',
        'log-bin'           => 'mysql-bin',
        'relay-log'         => 'mysql-relay-bin',
        'log-slave-updates' => '1',
        'read-only'         => '1',
        'replicate-do-db'   => ['demo'],
      },
    }
  }->

  mysql::db { 'demo':
    ensure   => 'present',
    user     => 'demo',
    password => 'changeme',
    host     => '%',
    grant    => ['all'],
}

exec { 'active slave':
 cwd => '/etc/puppetlabs/code/environments/production/',
 command => '/usr/bin/bash upslave.sh',
# creates => '/home/git/repos/puppetstart.git/HEAD',
}
notice("done script")

}






