# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  operating_system_fact = os[:family]
  redhat_six = os[:family] == 'redhat' && os[:release].to_i == 6

  before(:all) do
    inventory_hash = inventory_hash_from_inventory_file
    inventory_hash = add_feature_to_group(inventory_hash, 'puppet-agent', 'ssh_nodes')
    inventory_hash = add_feature_to_group(inventory_hash, 'puppet-agent', 'winrm_nodes')
    inventory_hash = add_feature_to_group(inventory_hash, 'puppet-agent', 'docker_nodes')
    write_to_inventory_file(inventory_hash, 'inventory.yaml')
  end

  describe 'install' do
    before(:all) do
      apply_manifest('package { "pry": ensure => absent, provider => "puppet_gem", }')
    end

    it 'installs pry', unless: (operating_system_fact == 'windows') do
      result = run_bolt_task('package', 'action' => 'install', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result.exit_code).to eq(0)
      expect(result['result']['status']).to match(%r{installed|install ok installed})
      expect(result['result']['version']).to match(%r{\d+\.\d+\.\d+})
    end

    it 'returns the version of pry', unless: (operating_system_fact == 'windows') || redhat_six do
      result = run_bolt_task('package', 'action' => 'status', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result.exit_code).to eq(0)
      expect(result['result']['status']).to match(%r{up to date|install ok installed})
      expect(result['result']['version']).to match(%r{\d+\.\d+\.\d+})
    end
  end

  describe 'install without puppet' do
    it 'installs rsyslog', unless: (operating_system_fact == 'windows') || redhat_six do
      result = run_bolt_task('package', 'action' => 'install', 'name' => 'rsyslog')
      expect(result.exit_code).to eq(0)
      expect(result['result']['status']).to match(%r{install|present})
    end
  end

  describe 'uninstall' do
    before(:all) do
      apply_manifest('package { "pry": ensure => "present", provider => "puppet_gem", }')
    end

    it 'uninstalls pry' do
      result = run_bolt_task('package', 'action' => 'uninstall', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result.exit_code).to eq(0)
      expect(result['result']['status']).to eq('uninstalled')
    end

    it 'status' do
      result = run_bolt_task('package', 'action' => 'status', 'name' => 'pry', 'provider' => 'puppet_gem')
      expect(result.exit_code).to eq(0)
      expect(result['result']['status']).to match(%r{absent|uninstalled})
    end
  end

  describe 'upgrade', if: (operating_system_fact == 'CentOS' && os[:release].to_i == 7) do
    before(:all) do
      apply_manifest('package { "httpd": ensure => "present", }')
    end

    it 'upgrade httpd' do
      result = run_bolt_task('package', 'action' => 'upgrade', 'name' => 'httpd')
      expect(result.exit_code).to eq(0)
      expect(result['result']['version']).to match(%r{2.4.6-\d+.el7.centos})
      expect(result['result']['old_version']).to match(%r{2.4.6-\d+.el7.centos})
    end
  end
end
