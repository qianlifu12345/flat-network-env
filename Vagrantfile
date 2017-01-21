# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#
$install_docker = <<INSTALL_DOCKER
echo Installing docker
curl -sSL https://get.docker.com | sed 's/apt-get install -y -q docker-engine/apt-get install -y -q docker-engine=1.12.3-0~trusty/g' | sh -
#curl -sSL https://get.docker.com | sh -
sudo usermod -aG docker vagrant
INSTALL_DOCKER

#$install_rancher_server = <<INSTALL_RANCHER_SERVER
#echo Installing Rancher Server
#sudo docker run -d --restart=always -p 8080:8080 rancher/server
#INSTALL_RANCHER_SERVER

Vagrant.configure(2) do |config|

  config.vm.provision "shell", inline: $install_docker
  config.vm.synced_folder "/Users/qian_lifu", "/lifuqian"

  config.vm.define "cattleh1" do |cattleh1|
    cattleh1.vm.hostname = 'cattleh1'
    cattleh1.vm.box= "ubuntu/trusty64"
    cattleh1.vm.box_url = "ubuntu/trusty64"

    cattleh1.vm.network :private_network, ip: "172.22.101.101",
      nic_type: "82545EM"

    cattleh1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh1"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-vms"]
    end
  end

  config.vm.define "cattleh2" do |cattleh2|
    cattleh2.vm.hostname = 'cattleh2'
    cattleh2.vm.box= "ubuntu/trusty64"
    cattleh2.vm.box_url = "ubuntu/trusty64"

    cattleh2.vm.network :private_network, ip: "172.22.101.102",
      nic_type: "82545EM"

    cattleh2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "cattleh2"]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-vms"]
    end
  end

#   config.vm.define "cattleh3" do |cattleh3|
#     cattleh3.vm.hostname = 'cattleh3'exit

#     cattleh3.vm.box= "ubuntu/trusty64"
#     cattleh3.vm.box_url = "ubuntu/trusty64"

#     cattleh3.vm.network :private_network, ip: "172.22.101.103",
#       nic_type: "82545EM"

#     cattleh3.vm.provider :virtualbox do |v|
#       v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
#       v.customize ["modifyvm", :id, "--memory", 2048]
#       v.customize ["modifyvm", :id, "--name", "cattleh3"]
#       v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
#     end
#   end
end

