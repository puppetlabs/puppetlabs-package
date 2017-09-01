# run a test task
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

    it 'applies a second time without changes', :skip_pup_5016 do
      apply_manifest(pp, catch_changes: true)
    end
  end
  describe 'init task' do
    it 'runs with bolt' do
      result = run_bolt_task(module_name: 'package', task_name: 'init')
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
    it 'runs with puppet task' do
      result = run_puppet_task(task_name: 'package')
      expect(result).to match(/declare -x OLDPWD/)
    end
  end
  describe 'package::status task' do
    it 'runs with bolt' do
      result = run_bolt_task(module_name: 'package', task_name: 'status', params: { 'name' => 'vim' })
      expect(result).to match(/declare -x OLDPWD/)
    end
    it 'runs with puppet task' do
      result = run_puppet_task(task_name: 'package::status', params: { 'name' => 'vim' })
      expect(result).to match(/declare -x OLDPWD/)
    end
  end
end
