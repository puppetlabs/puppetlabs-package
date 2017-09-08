# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install' do
    before(:all) do
      apply_manifest('package { "tmux": ensure => absent, }')
    end

    it 'installs tmux using pe' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'install', 'package' => 'tmux' })
      expect_multiple_regexes(result: result, regexes: [%r{status : installed}, %r{version : 1.\d}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
  describe 'uninstall' do
    before(:all) do
      apply_manifest('package { "tmux": ensure => "present", }')
    end

    it 'uninstalls tmux using pe' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'uninstall', 'package' => 'tmux' })
      expect_multiple_regexes(result: result, regexes: [%r{status : uninstalled}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
  describe 'upgrade', if: fact('osfamily') == 'RedHat' do
    before(:all) do
      apply_manifest('package { "vim-minimal": ensure => "2:7.4.160-1.el7", }')
    end

    it 'upgrades vim using pe' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'upgrade', 'package' => 'vim-minimal' })
      expect_multiple_regexes(result: result, regexes: [%r{version : 2:7.4.160-1.el7_3.1}, %r{old_version : 2:7.4.160-1.el7}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
  describe 'status' do
    context 'when package is present' do
      before(:all) do
        apply_manifest('package { "tmux": ensure => "present", }')
      end

      it 'returns the version of tmux using pe' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
        expect_multiple_regexes(result: result, regexes: [%r{status : up to date}, %r{Job completed. 1/1 nodes succeeded}])
      end
    end
    context 'when package is absent' do
      before(:all) do
        apply_manifest('package { "tmux": ensure => "absent", }')
      end

      it 'returns nothing using pe' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'doesntexist' })
        expect_multiple_regexes(result: result, regexes: [%r{status : failure}, %r{error : Tried to get latest on a missing package}])
      end
    end
  end
end
