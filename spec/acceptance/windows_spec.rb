# run a test task
require 'spec_helper_acceptance'

describe 'windows package task', if: os[:family] == 'windows' do
  include Beaker::TaskHelper::Inventory
  include BoltSpec::Run

  package_to_use = 'notepadplusplus.install'
  before(:all) do
    on(default, 'cmd.exe /c puppet module install puppetlabs-chocolatey')
    apply_manifest_on(default, 'include chocolatey')
  end

  describe 'install action' do
    it "install #{package_to_use}" do
      apply_manifest_on(default, "package { \"#{package_to_use}\": ensure => absent, }")
      result = task_run('package::windows','','','','action' => 'install', 'name' => package_to_use)
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['action']).to match(%r{install})
    end
  end

  describe 'uninstall action' do
    it "uninstall #{package_to_use}" do
      apply_manifest_on(default, "package { \"#{package_to_use}\": ensure => present, }")
      result = task_run('package::windows','','','','action' => 'uninstall', 'name' => package_to_use)
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['action']).to match(%r{uninstall})
    end
  end

  describe 'install specific' do
    it 'upgrade notepad++ to a specific version' do
      result = task_run('package::windows','','','','action' => 'upgrade', 'name' => package_to_use, 'version' => '7.5.5')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['action']).to match(%r{upgrade})
    end

    it 'upgrade notepad++' do
      result = task_run('package::windows','','','','action' => 'upgrade', 'name' => package_to_use)
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['action']).to match(%r{upgrade})
    end
  end
end
