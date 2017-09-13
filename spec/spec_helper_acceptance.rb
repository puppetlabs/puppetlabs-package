require 'puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ %r{pe}i
install_module_on(hosts)
install_module_dependencies_on(hosts)

UNSUPPORTED_PLATFORMS = %w[Windows Solaris AIX].freeze

DEFAULT_PASSWORD = if master[:hypervisor] == 'vagrant'
                     'vagrant'
                   elsif master[:hypervisor] == 'vcloud'
                     'Qu@lity!'
                   end

def run_puppet_access_login(user:, password: '~!@#$%^*-/ aZ', lifetime: '5y')
  on(master, puppet('access', 'login', '--username', user, '--lifetime', lifetime), stdin: password)
end

def run_bolt_task(task_name:, params: nil, password: DEFAULT_PASSWORD)
  on(master, "/opt/puppetlabs/puppet/bin/bolt run #{task_name} --modules /etc/puppetlabs/code/environments/production/modules --nodes localhost --password #{password} --params #{params}", acceptable_exit_codes: [0, 1]).stdout # rubocop:disable Metrics/LineLength
end

def run_puppet_task(task_name:, params: nil)
  file_path = master.tmpfile('task_params.json')
  create_remote_file(master, file_path, params.to_json)
  on(master, puppet('task', 'run', task_name, '--nodes', fact_on(master, 'fqdn'), '--params', "@#{file_path}"), acceptable_exit_codes: [0, 1]).stdout
end

def expect_multiple_regexes(result:, regexes:)
  regexes.each do |regex|
    expect(result).to match(regex)
  end
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    scp_to(master, 'bolt-0.0.6.gem', '/tmp')
    pp = <<-EOS
    package { 'bolt' :
      provider => 'puppet_gem',
      ensure   => 'installed',
      source   => '/tmp/bolt-0.0.6.gem'
    }
    EOS
    create_remote_file(hosts, '/tmp/gems.pp', pp)
    on(hosts, puppet('apply', '/tmp/gems.pp'), acceptable_exit_codes: [0, 1])

    run_puppet_access_login(user: 'admin')
    # FIXME: adreyer says "it only supports [code/environments/production/modules] orch is reading it directly and has no access to modulepath"
    on(master, 'mv /etc/puppetlabs/code/modules/package /etc/puppetlabs/code/environments/production/modules')
  end
end
