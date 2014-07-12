require 'spec_helper'

describe service('docker-registry') do
  it { should be_running }
  it { should be_enabled }
end

describe process("gunicorn") do
  it { should be_running }
  its(:args) { should match /docker_registry\.wsgi:application\b/ }
end

describe port(5000) do
  it { should be_listening }
end

describe command('wget -O- -q http://localhost/') do
    it { should return_stdout /docker-registry server \(prod\)/ }
end

describe command('wget -O- -q http://localhost/v1/_ping') do
    it { should return_stdout 'true' }
end
