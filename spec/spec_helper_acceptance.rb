require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ /pe/i
install_module_on(hosts)
install_module_dependencies_on(hosts)

UNSUPPORTED_PLATFORMS = ['Windows', 'Solaris', 'AIX']

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # fix the path
      on(host, "echo PATH=\"$PATH:/opt/puppetlabs/puppet/bin\"  >> /etc/bash.bashrc")
      
      scp_to(default, "bolt-0.0.6.gem", '/tmp')
pp=<<-EOS
package { 'net-netconf' :
  provider => 'puppet_gem',
  ensure   => 'installed',
  source   => '/tmp/bolt-0.0.6.gem'
}
EOS
      create_remote_file(default, "/tmp/gems.pp", pp)
      on host, puppet('apply','/tmp/gems.pp'), {:acceptable_exit_codes => [0,1] }
    end
  end
end
