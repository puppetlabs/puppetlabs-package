# run a test task
# executed with:
# BEAKER_destroy=no PUPPET_INSTALL_TYPE=pe BEAKER_PE_DIR=http://enterprise.delivery.puppetlabs.net/2017.3/ci-ready  BEAKER_PE_VER=2017.3.0-rc8-41-g4981bd3 BEAKER_set=centos7-pooler  bundle exec rspec spec/acceptance
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install' do
    it 'installs' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'install', 'package' => 'tmux' })
      expect(result).to match(%r{status : installed})
      expect(result).to match(%r{version : 1.\d})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'uninstall' do
    it_behaves_like 'applies cleanly', <<-EOS
      package { 'tmux':
        ensure => 'present',
      }
    EOS
    it 'uninstalls' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'uninstall', 'package' => 'tmux' })
      expect(result).to match(%r{status : uninstalled})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'status' do
    context 'when package is present' do
      it_behaves_like 'applies cleanly', <<-EOS
        package { 'tmux':
          ensure => 'present',
        }
      EOS
      it 'returns the version' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
        expect(result).to match(%r{status : installed})
        expect(result).to match(%r{version : 1.\d})
        expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
      end
    end
    context 'when package is absent' do
      it_behaves_like 'applies cleanly', <<-EOS
        package { 'tmux':
          ensure => 'absent',
        }
      EOS
      it 'returns nothing' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
        expect(result).to match(%r{status : absent})
        expect(result).to_not match(%r{version : 1.\d})
        expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
        expect(result).to match(%r{aoeu})
      end
    end
  end
  describe 'upgrade' do
    it_behaves_like 'applies cleanly', <<-EOS
      package { 'tmux':
        ensure => '1.7',
      }
    EOS
    it 'upgrades' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'upgrade', 'package' => 'tmux' })
      expect(result).to match(%r{version : 1.\d})
      expect(result).to match(%r{status : up to date})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
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
end
