#!/opt/puppetlabs/puppet/bin/ruby
require 'puppet'
require 'json'

def install(provider, _version)
  if [:absent, :purged].include?(provider.properties[:ensure])
    provider.install
    provider.flush
    { status: 'installed', version: provider.properties[:ensure] }
  else
    { status: 'present', version: provider.properties[:ensure] }
  end
end

def status(provider, _version)
  version = provider.properties[:ensure]
  latest = provider.latest
  if [:absent, :purged].include?(version)
    { status: 'absent', latest: latest }
  elsif version != latest
    { status: 'out of date', version: version, latest: latest }
  else
    { status: 'up to date', version: version }
  end
end

def uninstall(provider, _version)
  if [:absent, :purged].include?(provider.properties[:ensure])
    { status: 'absent' }
  else
    provider.uninstall
    provider.flush
    { status: 'uninstalled' }
  end
end

def upgrade(provider, version)
  old_version = provider.properties[:ensure]
  provider.resource[:ensure] = version unless version.nil?
  provider.update
  provider.flush
  { old_version: old_version, version: provider.properties[:ensure] }
end

params = JSON.parse(STDIN.read)
package = params['package']
provider = params['provider']
action = params['action']
version = params['version']

opts = { name: package }
opts[:provider] = provider if provider

begin
  provider = Puppet::Type.type(:package).new(opts).provider

  result = send(action, provider, version)
  puts result.to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end
