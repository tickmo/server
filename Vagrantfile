# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "meritieau/wheezy32"
  config.vm.hostname = "tickmo-web.dev"
  config.vm.network :forwarded_port, guest: 3000, host: 80
  config.vm.network :private_network, ip: "192.168.192.168"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
  config.vm.define "tickmo-web", hostname: "tickmo-web"
  config.vm.provision "shell", path: "vagrant/bootstrap.sh"
end
