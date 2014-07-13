require 'rake'
require 'rspec/core/rake_task'

desc "Run serverspec tests"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

desc "Test playbook syntax"
task :syntax do
  sh %{ansible-playbook -i tests/inventory --syntax-check tests/test.yml}
end

desc "Run ansible against localhost"
task :ansible do
  sh %{ansible-playbook -i tests/inventory tests/test.yml --connection=local --sudo}
  sh %{ansible-playbook -i tests/inventory tests/test.yml --connection=local --sudo \
       | grep -q 'changed=0.*failed=0' \
       && (echo 'Idempotence test: pass' && exit 0) \
       || (echo 'Idempotence test: fail' && exit 1)
  }
end

desc "Spin up vagrant instance"
task :vagrant_up do
  sh %{vagrant up}
end

desc "Run vagrant provision and check for changed/failed"
task :vagrant_provision do
  sh %{vagrant provision \ |
       grep -q 'changed=0.*failed=0' \
       && (echo 'Idempotence test: pass' && exit 0) \
       || (echo 'Idempotence test: fail' && exit 1)
  }
end

desc "Run travis tasks"
task :travis => [
  :syntax,
  :ansible,
  :spec
]

desc "Vagrant test suite"
task :vagrant => [
  :syntax,
  :vagrant_up,
  :vagrant_provision,
  :spec
]

task :default => :syntax
