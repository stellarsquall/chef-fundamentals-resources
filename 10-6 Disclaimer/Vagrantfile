# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-ohai")
  raise "vagrant-ohai plugin is not installed! Install with 'vagrant plugin install vagrant-ohai'"
end

NODE_SCRIPT = <<EOF.freeze
  echo "Preparing node..."
  # ensure the time is up to date
  yum -y install ntp
  systemctl start ntpd
  systemctl enable ntpd
  curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 12.21.4
EOF

def set_hostname(server)
  server.vm.provision 'shell', inline: "hostname #{server.vm.hostname}"
end

Vagrant.configure(2) do |config|

 config.vm.define 'web1' do |n|
    n.vm.box = 'bento/centos-7.2'
    n.vm.box_version = '2.2.9'
    n.vm.hostname = 'web1'
    n.vm.network :private_network, ip: '192.168.10.43', nic_type: "virtio"
    n.vm.provision :shell, inline: NODE_SCRIPT.dup
   set_hostname(n)
  end

 config.vm.define 'web2' do |n|
    n.vm.box = 'bento/centos-7.2'
    n.vm.box_version = '2.2.9'
    n.vm.hostname = 'web2'
    n.vm.network :private_network, ip: '192.168.10.44', nic_type: "virtio"
    n.vm.provision :shell, inline: NODE_SCRIPT.dup
   set_hostname(n)
  end

 config.vm.define 'load-balancer' do |n|
    n.vm.box = 'bento/centos-7.2'
    n.vm.box_version = '2.2.9'
    n.vm.hostname = 'load-balancer'
    n.vm.network "forwarded_port", guest: 80, host: 9000
    n.vm.provision :shell, inline: NODE_SCRIPT.dup
   set_hostname(n)
  end

end
