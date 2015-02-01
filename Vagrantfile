# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

boxes = YAML::load(File.open('config.yml'))['boxes']

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  boxes.each_with_index do |box, index|
    config.vm.define box['name'] do |node|
      node.vm.box = box['box']
      node.vm.hostname = 'docker-registry.local'
      node.ssh.insert_key = false

      node.vm.network "forwarded_port", guest: 80, host: "808#{index}"
      node.vm.network "private_network", ip: box['ip']

      node.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/set_inventory.yml"
        ansible.host_key_checking = false
      end
    end
  end
end
