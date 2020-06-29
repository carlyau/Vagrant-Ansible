# Ansible In A Box
## Introduction
This will create an ansible mananaged environment consisting of:

An ansible v2.9.9 Control node (control) and 4 Centos based managed nodes.

    1x Centos 8 (control)
    2x Centos 8 (node 1 & node 3)
    2x Centos 7 (node 2 & node 4)

These servers are also grouped within the ansible inventory (/home/ansible/inventory) as

    Centos - a parent group to Centos8 & Centos7
    Centos8 - node1 & node3
    Centos7 - node2 & node4
    Dev - node1 & node2
    Prod - node3 & node4

## Provisioning

To Provision this environment:

    Install virtualbox & vagrant
    download and unzip to a folder of choice
 
if you choose to, ahead of bringing up the lab, you could download the required vagrant boxes. These images are centos7 & centos8 images provided by hashicorp and include required virtualbox gues tools so that mounting guest directories is possible.If you choose not to download them, they will be pulled automatically the first time the "vagrant up" command is issued.
 
    # vagrant box add generic/centos8 --provider virtualbox
    # vagrant box add generic/centos7 --provider virtualbox
    # vagrant up 
    
you can also specify a single server using "vagrant up <server>"
    
    # vagrant up control
    # vagrant up node1 node4
    
## Logging In

Once the Lab is completed provisioning, you can log from a command line in using the "vagrant ssh" command.

    # vagrant ssh control
    
Once logged in, simply switch to the ansible user using the "su" command

```
sudo su - ansible
```    
From this host, you have ssh trust access to all 4 nodes should it be needed.

## Configuration

The ansible config file is located at /home/ansible/.ansible.cfg and overrides the default config located in /etc/ansible/ansible.cfg as long as you are executing as the ansible user.

All Ansible commands and playbooks should be performed as the ansible user.

A good, basic, sanity check is:

```
ansible all -m ping
```
This will send a python ping command to all hosts in the inventory.

```
[ansible@control ~]$ ansible all -m ping
node2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
node4 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
node1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
node3 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```
## Starting and Shutting down the environment
You can control startup and shutdown in the following ways

To start up the environment
```
# vagrant up
```
To Gracefully shut-down the environment:
```
# vagrant halt
```
To Suspend the environment:
```
# vagrant suspend
```

## Tearing down the environment

You can destroy a single server or the entire environment using:
    
    # vagrant destroy, or
    # vagrant destroy <server>
