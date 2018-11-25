node default {
#    include cron
package { 'ruby':
ensure => installed,
}
package { 'puppet-lint':
ensure => installed,
provider => gem,
}

package { 'r10k':
ensure => installed,
provider => puppet_gem,
}

cron { 'puppet-apply':
ensure  => present,
command =>' cd /etc/puppetlabs/code/environments/production ; /usr/bin/git pull origin master',
user    => root,
hour => '*',
minute => '*/1',
}

$value = (17 * 8) + (12 / 4) - 1
notice($value)
notice($value)
notice($value)
}
