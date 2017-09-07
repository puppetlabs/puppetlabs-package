# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install' do
    before(:all) do
      apply_manifest('package { "tmux": ensure => absent, }')
    end

    it 'installs' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'install', 'package' => 'tmux' })
      expect(result).to match(%r{status : installed})
      expect(result).to match(%r{version : 1.\d})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'uninstall' do
    before(:all) do
      apply_manifest('package { "tmux": ensure => "present", }')
    end

    it 'uninstalls' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'uninstall', 'package' => 'tmux' })
      expect(result).to match(%r{status : uninstalled})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'upgrade' do
    before(:all) do
      apply_manifest('package { "tmux": ensure => absent, }')
      apply_manifest('package { "tmux": ensure => "1.7", }')
    end

    it 'upgrades' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'upgrade', 'package' => 'tmux' })
      expect(result).to match(%r{version : 1.8})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'status' do
    context 'when package is present' do
      before(:all) do
        apply_manifest('package { "tmux": ensure => "present", }')
      end

      it 'returns the version' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
        expect(result).to match(%r{status : up to date})
        expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
      end
    end
    context 'when package is absent' do
      before(:all) do
        apply_manifest('package { "tmux": ensure => "absent", }')
      end

      it 'returns nothing' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'doesntexist' })
        expect(result).to match(%r{error : Tried to get latest on a missing package})
        expect(result).to match(%r{status : failure})
      end
    end
  end
end
