require 'spec_helper'

describe port(443) do
  it { should be_listening }
end

describe command('wget -O- --no-check-certificate -q https://localhost/') do
    its(:stdout) { should match /true/ }
end

describe command('wget -O- --no-check-certificate -q https://localhost/v1/_ping') do
    its(:stdout) { should match '{}' }
end
