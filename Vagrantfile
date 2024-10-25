# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  BOX_IMAGE = "ubuntu/jammy64"
  BASE_HOST_ONLY_NETWORK = "192.168.56"
  BASE_INT_NETWORK = "10.10.20"
  
  PROXY_URL = "http://10.20.5.51:8888"
  PROXY_ENABLE = false

  config.vm.define "web.m340" do |webvm340|
    webvm340.vm.box = BOX_IMAGE
    webvm340.vm.hostname = "web.m340"

    webvm340.vm.network "private_network", ip: "#{BASE_HOST_ONLY_NETWORK}.10"
    webvm340.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.10", virtualbox__intnet: "intnet"

    webvm340.vm.synced_folder "./www", "/var/www/html"
	
	if Vagrant.has_plugin?("vagrant-proxyconf") && PROXY_ENABLE
      webvm340.proxy.http     = PROXY_URL
      webvm340.proxy.https    = PROXY_URL
      webvm340.proxy.no_proxy = "localhost,127.0.0.1"
    end

    webvm340.vm.provision "shell", path: "scripts/install_adminer.sh"

    webvm340.vm.provider "virtualbox" do |webvm|
      webvm.name = "web.m340"
      webvm.gui = false
    end
    
  end

  config.vm.define "db.m340" do |dbvm340|
    dbvm340.vm.box = BOX_IMAGE
    dbvm340.vm.hostname = "db.m340"

    dbvm340.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.11", virtualbox__intnet: "intnet"

	if Vagrant.has_plugin?("vagrant-proxyconf") && PROXY_ENABLE
      dbvm340.proxy.http     = PROXY_URL
      dbvm340.proxy.https    = PROXY_URL
      dbvm340.proxy.no_proxy = "localhost,127.0.0.1"
    end
	
	dbvm340.vm.provision "shell", path: "scripts/install_mysql.sh"
	
    dbvm340.vm.provider "virtualbox" do |dbvm|
      dbvm.name = "db.m340"
      dbvm.gui = false
    end
    
  end
end
