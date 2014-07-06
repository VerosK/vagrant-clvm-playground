
notify{"Started on  ${fqdn}": }

package{"lvm2-cluster":
  ensure => present
}