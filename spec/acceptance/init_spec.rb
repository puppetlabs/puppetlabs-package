# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install', if: pe_install? do
    before(:all) do
      apply_manifest('package { "tmux": ensure => absent, }')
    end
    it 'installs tmux' do
      result = run_task(task_name: 'package', params: 'action=install package=tmux')
      expect_multiple_regexes(result: result, regexes: [%r{status : installed}, %r{version : \d.\d}, %r{Job completed. 1/1 nodes succeeded}])
    end
    it 'returns the version of tmux' do
      result = run_task(task_name: 'package', params: 'action=status package=tmux')
      expect_multiple_regexes(result: result, regexes: [%r{status : up to date}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
  describe 'uninstall', if: pe_install? do
    before(:all) do
      apply_manifest('package { "tmux": ensure => "present", }')
    end

    it 'uninstalls tmux' do
      result = run_task(task_name: 'package', params: 'action=uninstall package=tmux')
      expect_multiple_regexes(result: result, regexes: [%r{status : uninstalled}, %r{Job completed. 1/1 nodes succeeded}])
    end
    it 'status' do
      result = run_task(task_name: 'package', params: 'action=status package=tmux')
      expect_multiple_regexes(result: result, regexes: [%r{status : absent}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
  describe 'upgrade', if: (fact('operatingsystem') == 'CentOS' && fact('operatingsystemmajrelease') == '7' && pe_install?) do
    it 'upgrade httpd to a specific version' do
      result = run_task(task_name: 'package', params: 'action=upgrade package=httpd version=2.4.6-45.el7.centos')
      expect_multiple_regexes(result: result, regexes: [%r{version : 2.4.6-45.el7.centos}, %r{Job completed. 1/1 nodes succeeded}])
    end

    it 'upgrade httpd' do
      result = run_task(task_name: 'package', params: 'action=upgrade package=httpd')
      expect_multiple_regexes(result: result, regexes: [%r{version : 2.4.6-45.el7.centos.4}, %r{old_version : 2.4.6-45.el7.centos}, %r{Job completed. 1/1 nodes succeeded}])
    end
  end
end
