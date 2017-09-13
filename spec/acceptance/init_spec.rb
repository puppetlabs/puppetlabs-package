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
    it 'returns the version of tmux using pe' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
      expect_multiple_regexes(result: result, regexes: [%r{status : up to date}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
  describe 'install using bolt' do
    before(:all) do
      apply_manifest('package { "tmux": ensure => absent, }')
    end

    it 'installs tmux using bolt' do
      pending 'bolt does not accept params yet'
      result = run_bolt_task(task_name: 'package', params: { 'action' => 'install', 'package' => 'tmux' })
      expect_multiple_regexes(result: result, regexes: [%r{status : installed}, %r{version : 1.\d}, %r{Job completed. 1/1 nodes succeeded}])
    end
    it 'returns the version of tmux using bolt' do
      pending 'bolt does not accept params yet'
      result = run_bolt_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
      expect_multiple_regexes(result: result, regexes: [%r{status : up to date}, %r{Job completed. 1/1 nodes succeeded}])
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
    it 'status' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
        expect_multiple_regexes(result: result, regexes: [%r{status : failure}, %r{error : Tried to get latest on a missing package}])
    end
  end
  describe 'upgrade', if: fact('operatingsystem') == 'Centos' do
    it 'upgrade httpd using pe to a specific version' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'upgrade', 'package' => 'httpd', 'version' => '2.4.6-45.el7.centos' })
      expect_multiple_regexes(result: result, regexes: [%r{version : 2.4.6-45.el7.centos}, %r{Job completed. 1/1 nodes succeeded}])
    end

    it 'upgrade httpd using pe' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'upgrade', 'package' => 'httpd' })
      expect_multiple_regexes(result: result, regexes: [%r{version : 2.4.6-45.el7.centos.4}, %r{old_version : 2.4.6-45.el7.centos}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
end
