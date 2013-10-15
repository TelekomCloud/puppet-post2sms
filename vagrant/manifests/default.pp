class { 'post2sms':
  gw_host => 'http://localhost:8081'
}

# inside vagrant, to rerun puppet apply:
# puppet apply --detailed-exitcodes /tmp/vagrant-puppet/manifests/default.pp --modulepath=/tmp/vagrant-puppet/modules-0:/etc/puppet/modules  || [ $? -eq 2 ]

# just for convenience:
package { 'vim': }
package { 'curl': }