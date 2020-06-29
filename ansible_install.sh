ansible_user="ansible"
ansible_inventory='[centos8]
node1
node3

[centos7]
node2
node4

[centos:children]
centos7
centos8

[dev]
node1
node2

[prod]
node3
node4'

if [ $(rpm -q --quiet ${ansible_user};echo $?) -eq 0 ]
then
  #ansible is installed already
  exit 0
fi

yum -y install http://mirror.centos.org/centos-8/8/extras/x86_64/os/Packages/centos-release-ansible-29-1-2.el8.noarch.rpm
echo ${ansible_inventory} > /home/${ansible_user}/inventory

cat > /home/${ansible_user}/.ansible.cfg<<EOF
[defaults]
inventory = "/home/${ansible_user}/inventory"
remote_user = "${ansible_user}"
roles_path = "/home/${ansible_user}/roles"
host_key_checking = false

[privilege_escalation]
become_user = "root"
ansible_ask_pass = false
become = true
EOF

chown -R ${ansible_user}:${ansible_user} /home/${ansible_user}

yum -y install ansible rsync
echo "installing pywinrm"
pip3 install pywinrm
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g;s/#UseDNS no/UseDNS no/' /etc/ssh/sshd_config
systemctl restart sshd
