# run a test task
require 'spec_helper_acceptance'

describe 'windows package task', if: fact('osfamily') == 'windows' do
  package_to_use = 'vim'
  before(:all) do
    on(host, 'puppet module install puppetlabs-chocolatey')
    apply_manifest('include chocolatey')
  end
  describe 'install action' do
    it "install #{package_to_use}" do
      apply_manifest("package { \"#{package_to_use}\": ensure => absent, }")
      result = run_task(task_name: 'package::windows', params: "action=install name=#{package_to_use}")
      expect_multiple_regexes(result: result, regexes: [%r{install}, %r{(Job completed. 1/1 nodes succeeded|Ran on 1 node)}])
    end
  end
  describe 'uninstall action' do
    it "uninstall #{package_to_use}" do
      apply_manifest("package { \"#{package_to_use}\": ensure => present, }")
      result = run_task(task_name: 'package::windows', params: "action=uninstall name=#{package_to_use}")
      expect_multiple_regexes(result: result, regexes: [%r{install}, %r{(Job completed. 1/1 nodes succeeded|Ran on 1 node)}])
    end
  end
  describe 'install specific' do
    it 'upgrade httpd to a specific version' do
      result = run_task(task_name: 'package::windows', params: 'action=upgrade name=apache-httpd version=2.4.32')
      expect_multiple_regexes(result: result, regexes: [%r{Job completed. 1/1 nodes succeeded}])
    end

    it 'upgrade httpd' do
      result = run_task(task_name: 'package::windows', params: 'action=upgrade name=apache-httpd')
      expect_multiple_regexes(result: result, regexes: [%r{Job completed. 1/1 nodes succeeded}])
    end
  end
end
