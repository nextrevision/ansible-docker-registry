require 'spec_helper'

describe package('nginx-extras') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/nginx/sites-enabled/docker-registry') do
  it { should be_file }
  its(:content) { should match /server localhost:5000;/ }
end
