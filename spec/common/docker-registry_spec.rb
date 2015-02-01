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
