# for serverspec documentation: http://serverspec.org/
require_relative 'spec_helper'

pkgs = ['unzip']

pkgs.each do |pkg|
  describe package("#{pkg}") do
    it { should be_installed }
  end
end

describe service('vault') do
  it { should be_running.under('upstart') }
end

describe port(8200) do
  it { should be_listening }
end

describe file('/usr/local/bin/vault') do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
end

describe file('/etc/vault/config.hcl') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe file('/etc/init/vault.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end
