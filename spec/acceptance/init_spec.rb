# frozen_string_literal: true

# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  operating_system_fact = os[:family]

  before(:each) do
    skip "Don't run on Windows" if operating_system_fact == 'windows'
  end

  describe 'install' do
    context 'when default' do
      before(:all) do
        apply_manifest('package { "pry": ensure => absent, provider => "puppet_gem", }')
      end

      it 'installs pry' do
        result = run_bolt_task('package', 'action' => 'install', 'name' => 'pry', 'provider' => 'puppet_gem')
        expect(result.exit_code).to eq(0)
        expect(result['result']['status']).to eq('installed')
        expect(result['result']['version']).to match(%r{\d+\.\d+\.\d+})
      end

      it 'returns the version of pry' do
        result = run_bolt_task('package', 'action' => 'status', 'name' => 'pry', 'provider' => 'puppet_gem')
        expect(result.exit_code).to eq(0)
        expect(result['result']['status']).to match(%r{up to date|installed})
        expect(result['result']['version']).to match(%r{\d+\.\d+\.\d+})
      end
    end

    context 'with version' do
      before(:all) do
        apply_manifest('package { "pry": ensure => absent, provider => "puppet_gem", }')
      end

      it 'installs pry v0.12.0' do
        result = run_bolt_task('package', 'action' => 'install', 'name' => 'pry', 'provider' => 'puppet_gem', 'version' => '0.12.0')
        expect(result.exit_code).to eq(0)
        expect(result['result']['status']).to eq('installed')
        expect(result['result']['version']).to match(%r{\d+\.\d+\.\d+})
      end

      it 'returns the correct version of pry' do
        result = run_bolt_task('package', 'action' => 'status', 'name' => 'pry', 'provider' => 'puppet_gem')
        expect(result.exit_code).to eq(0)
        expect(result['result']['status']).to match(%r{out of date})
        expect(result['result']['version']).to match(%r{0.12.0})
      end
    end
  end

  describe 'install without puppet' do
    it 'installs rsyslog' do
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
