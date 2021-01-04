# frozen_string_literal: true

# run a test task
require 'spec_helper_acceptance'

describe 'windows package task', if: os[:family] == 'windows' do
  package_to_use = 'notepadplusplus.install'
  target_host = ENV['TARGET_HOST']
  before(:all) do
    command_string = 'cmd.exe /c puppet module install puppetlabs-chocolatey'
    command_string += " --modulepath #{Dir.pwd}/spec/fixtures/modules" if target_host.nil? || target_host == 'localhost'
    run_shell(command_string)
    pp = <<-PUPPETCODE
    include chocolatey
PUPPETCODE
    apply_manifest(pp)
  end

  describe 'install action' do
    it "install #{package_to_use}" do
      apply_manifest("package { \"#{package_to_use}\": ensure => absent,  }")
      result = run_bolt_task('package::windows', 'action' => 'install', 'name' => package_to_use)
      expect(result.exit_code).to eq(0)
      expect(result['result']).to include('status' => %r{Install})
      expect(result['result']).to include('version')
    end
  end

  describe 'uninstall action' do
    it "uninstall #{package_to_use}" do
      apply_manifest("package { \"#{package_to_use}\": ensure => present, provider => 'chocolatey' }")
      result = run_bolt_task('package::windows', 'action' => 'uninstall', 'name' => package_to_use)
      expect(result.exit_code).to eq(0)
      expect(result['result']).to include('status' => %r{Uninstall})
    end
  end

  describe 'install specific' do
    it 'upgrade notepad++ to a specific version' do
      result = run_bolt_task('package::windows', 'action' => 'upgrade', 'name' => package_to_use, 'version' => '7.5.5')
      expect(result.exit_code).to eq(0)
      expect(result['result']).to include('status' => %r{Upgrade})
      expect(result['result']).to include('old_version')
      expect(result['result']).to include('version')
    end

    it 'upgrade notepad++' do
      result = run_bolt_task('package::windows', 'action' => 'upgrade', 'name' => package_to_use)
      expect(result.exit_code).to eq(0)
      expect(result['result']).to include('status' => %r{Upgrade})
      expect(result['result']).to include('old_version')
      expect(result['result']).to include('version')
    end
  end

  describe 'status action' do
    it "status #{package_to_use} (installed)" do
      apply_manifest("package { \"#{package_to_use}\": ensure => present, provider => 'chocolatey' }")
      result = run_bolt_task('package::windows', 'action' => 'status', 'name' => package_to_use)
      expect(result.exit_code).to eq(0)
      expect(result['result']).to include('status' => %r{Installed})
      expect(result['result']).to include('version')
    end

    it "status #{package_to_use} (uninstalled)" do
      apply_manifest("package { \"#{package_to_use}\": ensure => absent, provider => 'chocolatey' }")
      result = run_bolt_task('package::windows', 'action' => 'status', 'name' => package_to_use)
      expect(result.exit_code).to eq(0)
      expect(result['result']).to include('status' => %r{Uninstalled})
    end
  end
end
