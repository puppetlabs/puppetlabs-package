require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ /pe/i
install_module_on(hosts)
install_module_dependencies_on(hosts)

UNSUPPORTED_PLATFORMS = ['Windows', 'Solaris', 'AIX']

DEFAULT_PASSWORD = if master[:hypervisor] == 'vagrant'
                     'vagrant'
                   elsif master[:hypervisor] == 'vcloud'
                     '~!@#$%^*-/ aZ'
                   end

def run_puppet_access_login(user:, password: DEFAULT_PASSWORD, lifetime: "5y")
  # FIXME: read user/password on stdin
  on(master, puppet('access', 'login', user, password, '--lifetime', lifetime))
end

def run_bolt_task(module_name:, task_name:, params: nil, password: DEFAULT_PASSWORD)
  on(master, "bolt run /etc/puppetlabs/code/environments/production/modules/#{module_name}/tasks/#{task_name} --nodes localhost --password #{password}", acceptable_exit_codes: [0, 1]).stdout
end

def run_puppet_task(task_name:, params: nil)
  # FIXME: adreyer says "I thought the not passing environment bug was fixed" so --environment may not be needed
  # FIXME: check how apply_manifest() does temp files for the params file
  on(master, puppet('task', 'run', task_name, '--nodes', fact_on(master, 'fqdn'), '--environment', 'production', '--params-file', tempfile), acceptable_exit_codes: [0, 1]).stdout
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # fix the path
    on(master, "echo PATH=\"$PATH:/opt/puppetlabs/puppet/bin\"  >> /etc/bash.bashrc")

    scp_to(master, "bolt-0.0.6.gem", '/tmp')
    pp = <<-EOS
    package { 'net-netconf' :
      provider => 'puppet_gem',
      ensure   => 'installed',
      source   => '/tmp/bolt-0.0.6.gem'
    }
    EOS
    create_remote_file(hosts, '/tmp/gems.pp', pp)
    on(hosts, puppet('apply', '/tmp/gems.pp'), acceptable_exit_codes: [0, 1])

    run_puppet_access_login(user: 'admin', password: '~!@#$%^*-/ aZ')
    # FIXME: adreyer says "it only supports [code/environments/production/modules] orch is reading it directly and has no access to modulepath"
    on(master, 'mv /etc/puppetlabs/code/modules/package /etc/puppetlabs/code/environments/production/modules')
  end
end
