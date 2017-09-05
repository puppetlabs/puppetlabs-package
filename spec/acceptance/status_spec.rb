# run a test task
# executed with:
# BEAKER_destroy=no PUPPET_INSTALL_TYPE=pe BEAKER_PE_DIR=http://enterprise.delivery.puppetlabs.net/2017.3/ci-ready  BEAKER_PE_VER=2017.3.0-rc8-41-g4981bd3 BEAKER_set=centos7-pooler  bundle exec rspec spec/acceptance
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install vim, via package' do
    let(:pp) do
      <<-EOS
        package { 'vim':
          name => 'vim',
          ensure => latest
        }
      EOS
    end

    it 'applies with no errors' do
      apply_manifest(pp, catch_failures: true)
    end

    it 'applies a second time without changes' do
      apply_manifest(pp, catch_changes: true)
    end
  end

  describe 'try_me task' do
    it 'runs with bolt' do
      result = run_bolt_task(module_name: 'package', task_name: 'try_me')
      expect(result).to match(/declare -x OLDPWD/)
      # example cli 
      # bolt run /etc/puppetlabs/code/modules/package/tasks/init --nodes localhost --password vagrant
      # bolt exec --nodes localhost --password vagrant command='ls -l /'
      # /opt/puppetlabs/puppet/bin/ruby /etc/puppetlabs/code/modules/package/tasks/status
      # then type 
      # { "name": "vim" }
      # then hit <enter>
      # then <CTRL> + d
    end
  end

  # basically puppet task run package  --nodes fdsvtncz1jg98t9.delivery.puppetlabs.net --params-file bla.json
  # example params-file bla.json
  #{
  #  "action":  "install",
  #  "package": "emacs"
  #}
  describe 'package::status task' do
    it 'runs with puppet task' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'install', 'package' => 'emacs' })
      expect(result).to match(/status : installed/)
      expect(result).to match(/installed/)
      expect(result).to match(/Job completed. 1\/1 nodes succeeded/)
    end
  end
end
