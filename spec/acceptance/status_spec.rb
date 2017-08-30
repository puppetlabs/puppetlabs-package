# run a test task
require 'spec_helper_acceptance'

describe 'package task' do
  describe 'install vim, via package' do
    let(:pp) do
      <<-EOS
        package { 'vim':
          name => 'vim',
          ensure => latest
        }
      EOS
    end
    it 'should apply with no errors' do
      apply_manifest(pp, :catch_failures => true)
    end

    it 'should apply a second time without changes', :skip_pup_5016 do
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
