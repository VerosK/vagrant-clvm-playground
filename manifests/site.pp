
notify{"Started on  ${fqdn}": }

package{"lvm2-cluster":
  ensure => present
}

# set default
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class {"corosync":
  enable_secauth    => false,
  port => 5405,
#  authkey           => '/var/lib/puppet/ssl/certs/ca.pem',
  bind_address      => $ipaddress,
  multicast_address => '239.1.1.2',
}
