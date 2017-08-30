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
    it 'should apply with no errors' do
      apply_manifest(pp, :catch_failures => true)
    end

    it 'should apply a second time without changes', :skip_pup_5016 do
      apply_manifest(pp, :catch_changes => true)
    end
  end
  describe 'run a simple init task' do
    result = run_task(task_name: 'init')
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
