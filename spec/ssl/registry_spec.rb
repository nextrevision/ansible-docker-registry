require 'spec_helper'

describe port(443) do
  it { should be_listening }
end

describe command('wget -O- --no-check-certificate -q https://localhost/') do
    it { should return_stdout /true/ }
end

describe command('wget -O- --no-check-certificate -q https://localhost/v1/_ping') do
    it { should return_stdout '{}' }
end
