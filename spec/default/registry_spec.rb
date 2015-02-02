require 'spec_helper'

describe port(80) do
  it { should be_listening }
end

describe command('wget -O- -q http://localhost/') do
    its(:stdout) { should match /true/ }
end

describe command('wget -O- -q http://localhost/v1/_ping') do
    its(:stdout) { should match '{}' }
end
