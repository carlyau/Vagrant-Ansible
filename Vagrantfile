# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANT_DISABLE_VBOXSYMLINKCREATE = "1"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Global setttings
  # Use same SSH key for each machine
  config.vm.provider "virtualbox"
  config.vm.provider "virtualbox" do | vm |
    vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vm.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
	  vm.linked_clone = true
    vm.memory = "256"
    vm.cpus = "1"
  end
  config.vm.usable_port_range = 2222..2229
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.box = "generic/centos8"
  config.vm.provision :shell, path: "create_ansible_user.sh"

  # Ansible Control Node
  config.vm.define "control" do |control|
    control.vm.provider "virtualbox" do |control|
	    control.cpus = "2"
      control.memory = "1024"
      control.name = "Ansible_Control"
    end 
    control.vm.hostname = "control"
    control.vm.network "private_network", ip: "192.168.56.200"
	  control.vm.provision :shell, path: "ansible_install.sh"
    control.vm.synced_folder "./Ansible_Share", "/ansible", create: true
	  control.trigger.before :destroy do |trigger|
	    trigger.warn = "Copying Ansible content in /ansible to Ansible_Share"
	    trigger.run_remote = {inline: "rsync -avz /home/ansible/* /ansible/"}
	  end
  end

  # Ansible Managed Nodes below
  config.vm.define "node1" do |node1|
    node1.vm.provider "virtualbox" do |node1|
      node1.name = "Ansible_Node_1"
    end
    node1.vm.hostname = "node1"
    node1.vm.network "private_network", ip: "192.168.56.201"
  end
  config.vm.define "node2" do |node2|
    node2.vm.provider "virtualbox" do |node2|
      node2.name = "Ansible_Node_2"
    end
    node2.vm.box = "generic/centos7"
    node2.vm.hostname = "node2"
    node2.vm.network "private_network", ip: "192.168.56.202"
  end
  config.vm.define "node3" do |node3|
    node3.vm.provider "virtualbox" do |node3|
      node3.name = "Ansible_Node_3"
    end
    node3.vm.hostname = "node3"
    node3.vm.network "private_network", ip: "192.168.56.203"
  end
  config.vm.define "node4" do |node4|
    node4.vm.provider "virtualbox" do |node4|
      node4.cpus = "2"
      node4.name = "Ansible_Node_4"
    end
    node4.vm.box = "generic/centos7"
    node4.vm.hostname = "node4"
    node4.vm.network "private_network", ip: "192.168.56.204"
  end
end
