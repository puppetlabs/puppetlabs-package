# run a test task
require 'spec_helper_acceptance'

describe 'linux package task', unless: fact('osfamily') == 'windows' do
  include Beaker::TaskHelper::Inventory
  include BoltSpec::Run

  redhat_six = os[:family] == 'redhat' && os[:release].to_i  == 6
  windows = os[:family] == 'windows'

  describe 'install action' do
    it 'install rsyslog', unless: redhat_six || windows do
      apply_manifest_on(default, "package { 'rsyslog': ensure => absent, }")
      result = task_run('package::linux', 'action' => 'install', 'name' => 'rsyslog')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to match(%r{install})
    end
  end

  describe 'uninstall action', unless: redhat_six || windows do
    it 'uninstall rsyslog' do
      apply_manifest_on(default, "package { 'rsyslog': ensure => present, }")
      result = task_run('package::linux', 'action' => 'uninstall', 'name' => 'rsyslog')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to match(%r{uninstall})
    end
  end

  describe 'upgrade', if: (fact('operatingsystem') == 'CentOS' && fact('operatingsystemmajrelease') == '7') do
    it 'upgrade httpd' do
      apply_manifest_on(default, 'package { "httpd": ensure => "present", }')
      result = task_run('package::linux', 'action' => 'upgrade', 'name' => 'httpd')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to match(%r{upgrade})
    end
  end
end
