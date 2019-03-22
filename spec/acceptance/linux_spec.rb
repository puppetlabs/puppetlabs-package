# run a test task
require 'spec_helper_acceptance'

# Red-Hat 6 is the only platform we cannot reliably perform package actions on
redhat_six = os[:family] == 'redhat' && os[:release].to_i == 6
windows = os[:family] == 'windows'

describe 'linux package task', unless: redhat_six || windows do
  describe 'install action' do
    it 'installs rsyslog' do
      apply_manifest_on(default, "package { 'rsyslog': ensure => absent, }")
      result = task_run('package::linux', '', '', '', 'action' => 'install', 'name' => 'rsyslog')
      expect(result[0]).to include('status' => 'success')
      expect(result[0]['result']).to include('status' => %r{install})
      expect(result[0]['result']).to include('version')
    end

    it 'errors gracefully when bogus package requested' do
      result = task_run('package::linux', '', '', '', 'action' => 'install', 'name' => 'foo')
      expect(result[0]).to include('status' => 'failure')
      expect(result[0]['result']).to include('status' => 'failure')
      expect(result[0]['result']['_error']).to include('msg')
      expect(result[0]['result']['_error']).to include('kind' => 'bash-error')
      expect(result[0]['result']['_error']).to include('details')
    end
  end

  describe 'status action' do
    it 'status rsyslog' do
      apply_manifest_on(default, "package { 'rsyslog': ensure => present, }")
      result = task_run('package::linux', '', '', '', 'action' => 'status', 'name' => 'rsyslog')
      expect(result[0]).to include('status' => 'success')
      expect(result[0]['result']).to include('status' => %r{install})
      expect(result[0]['result']).to include('version')
    end
  end

  describe 'uninstall action' do
    it 'uninstall rsyslog' do
      apply_manifest_on(default, "package { 'rsyslog': ensure => present, }")
      result = task_run('package::linux', '', '', '', 'action' => 'uninstall', 'name' => 'rsyslog')
      expect(result[0]).to include('status' => 'success')
      expect(result[0]['result']).to include('status' => %r{not install|deinstall})
    end
  end

  describe 'upgrade' do
    it 'upgrade rsyslog' do
      apply_manifest_on(default, "package { 'rsyslog': ensure => present, }")
      result = task_run('package::linux', '', '', '', 'action' => 'upgrade', 'name' => 'rsyslog')
      expect(result[0]).to include('status' => 'success')
      expect(result[0]['result']).to include('old_version')
      expect(result[0]['result']).to include('version')
    end
  end
end
