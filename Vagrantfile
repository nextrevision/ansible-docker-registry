# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = 'docker-registry.local'

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.59.4"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/vagrant.yml"
    ansible.host_key_checking = false
  end
end
