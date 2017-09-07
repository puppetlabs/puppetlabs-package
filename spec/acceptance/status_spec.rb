# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install' do
    it 'installs' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'install', 'package' => 'tmux' })
      expect(result).to match(%r{status : installed})
      expect(result).to match(%r{version : 1.\d})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'uninstall' do
    let(:pp) do
      <<-EOS
      package { 'tmux':
        ensure => 'present',
      }
    EOS
    end

    it_behaves_like 'applies cleanly'
    it 'uninstalls' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'uninstall', 'package' => 'tmux' })
      expect(result).to match(%r{status : uninstalled})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'upgrade', if: fact('operatingsystem') =~ %r{Redhat} do
    let(:pp) do
      <<-EOS
      package { 'vim-minimal.x86_64':
        ensure => '2:7.4.160-1.el7',
      }
    EOS
    end

    it_behaves_like 'applies cleanly'
    it 'upgrades' do
      result = run_puppet_task(task_name: 'package', params: { 'action' => 'upgrade', 'package' => 'vim-minimal.x86_64' })
      expect(result).to match(%r{version : 2:7.4.160-1.el7_3.1})
      expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
    end
  end
  describe 'status' do
    context 'when package is present' do
      let(:pp) do
        <<-EOS
        package { 'tmux':
          ensure => 'present',
        }
      EOS
      end

      it_behaves_like 'applies cleanly'
      it 'returns the version' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'tmux' })
        expect(result).to match(%r{status : up to date})
        expect(result).to match(%r{Job completed. 1/1 nodes succeeded})
      end
    end
    context 'when package is absent' do
      it 'returns nothing' do
        result = run_puppet_task(task_name: 'package', params: { 'action' => 'status', 'package' => 'doesntexist' })
        expect(result).to match(%r{error : Tried to get latest on a missing package})
        expect(result).to match(%r{status : failure})
      end
    end
  end
end
