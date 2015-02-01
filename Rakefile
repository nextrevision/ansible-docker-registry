require 'rake'
require 'yaml'
require 'rspec/core/rake_task'

# load config
config = YAML::load(File.open('config.yml'))

# ansible config
ansible_env="PYTHONUNBUFFERED=1 " +
            "ANSIBLE_FORCE_COLOR=true " +
            "ANSIBLE_HOST_KEY_CHECKING=false " +
            "ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'"
ansible_inventory=".vagrant/provisioners/ansible/inventory"

# syntax task
desc "Test playbook syntax"
task :syntax do
  sh %{ansible-playbook -i tests/inventory --syntax-check tests/test.yml}
end

# serverspec tasks
namespace "serverspec" do
  config['boxes'].each do |box|
    namespace box['name'] do
      box['scenarios'].each do |scenario|
        desc "Run serverspec against #{box['name']} with scenario #{scenario}"
        RSpec::Core::RakeTask.new(scenario) do |t|
          ENV['TARGET_BOX'] = box['name']
          t.pattern = 'spec/{common,' + scenario + '}/*_spec.rb'
        end
      end
    end
  end
end

# ansible tasks
namespace "ansible" do
  config['boxes'].each do |box|
    namespace box['name'] do
      box['scenarios'].each do |scenario|
        desc "Run ansible against #{box['name']} with scenario #{scenario}"
        task scenario do
          extra_vars = config['scenarios'][scenario].map{|k,v| "#{k}=#{v}"}.join(' ')
          ansible_key = `vagrant ssh-config trusty | grep IdentityFile | awk '{ print $2 }' | tr -d "\n"`
          sh %{#{ansible_env} ansible-playbook --private-key=#{ansible_key} --user=vagrant --connection=ssh --limit='#{box['name']}' --inventory-file=#{ansible_inventory} --extra-vars='#{extra_vars}' tests/vagrant.yml}
        end
      end
    end
  end
end

# vagrant up tasks
namespace "vagrant_up" do
  config['boxes'].each do |box|
    desc "Spin up vagrant instance #{box['name']}"
    task box['name'] do
      sh %{vagrant up #{box['name']}}
    end
  end
end

# test suite wrapper
config['boxes'].each do |box|
  namespace box['name'] do
    box['scenarios'].each do |scenario|
      desc "Vagrant test suite for #{box['name']}"
      task scenario => [
        :syntax,
        "vagrant_up:#{box['name']}",
        "ansible:#{box['name']}:#{scenario}",
        "serverspec:#{box['name']}:#{scenario}"
      ]
    end
  end
end
