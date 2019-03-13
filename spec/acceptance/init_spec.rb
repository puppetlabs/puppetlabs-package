# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  include Beaker::TaskHelper::Inventory
  include BoltSpec::Run

  operating_system_fact = os[:family]
  redhat_six = os[:family] == 'redhat' && os[:release].to_i == 6

  def set_puppet_agent_inventory
    hosts_to_inventory.merge('features' => ['puppet-agent'])
  end

  describe 'install' do
    before(:all) do
      apply_manifest_on(default, 'package { "pry": ensure => absent, provider => "puppet_gem", }')
    end

    it 'installs pry', unless: (operating_system_fact == 'windows') do
      result = task_run('package', '', '', set_puppet_agent_inventory, 'action' => 'install', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to eq('installed')
      expect(result[0]['result']['version']).to match(%r{\d+\.\d+\.\d+})
    end

    it 'returns the version of pry', unless: (operating_system_fact == 'windows') || redhat_six do
      result = task_run('package', '', '', set_puppet_agent_inventory, 'action' => 'status', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to eq('up to date')
      expect(result[0]['result']['version']).to match(%r{\d+\.\d+\.\d+})
    end
  end

  describe 'install without puppet' do
    it 'installs rsyslog', unless: (operating_system_fact == 'windows') || redhat_six do
      result = task_run('package', '', '', hosts_to_inventory, 'action' => 'install', 'name' => 'rsyslog')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to match(%r{install|present})
    end
  end

  describe 'uninstall' do
    before(:all) do
      apply_manifest_on(default, 'package { "pry": ensure => "present", provider => "puppet_gem", }')
    end

    it 'uninstalls pry' do
      result = task_run('package', '', '', set_puppet_agent_inventory, 'action' => 'uninstall', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to eq('uninstalled')
    end
    it 'status' do
      result = task_run('package', '', '', set_puppet_agent_inventory, 'action' => 'status', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['status']).to eq('absent')
    end
  end

  describe 'upgrade', if: (operating_system_fact == 'CentOS' && os[:release].to_i == 7) do
    before(:all) do
      apply_manifest_on(default, 'package { "httpd": ensure => "present", }')
    end

    it 'upgrade httpd' do
      result = task_run('packages', '', '', set_puppet_agent_inventory, 'action' => 'upgrade', 'name' => 'httpd')
      expect(result[0]['status']).to eq('success')
      expect(result[0]['result']['version']).to match(%r{2.4.6-\d+.el7.centos})
      expect(result[0]['result']['old_version']).to match(%r{2.4.6-\d+.el7.centos})
    end
  end
end
