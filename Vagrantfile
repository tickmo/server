# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "tickmo-web.dev"

    # Network config & shared folders
    config.vm.network "private_network", ip: "192.168.33.139"

    # VM definition
    config.vm.provider "virtualbox" do |vb|
        vb.name = "tickmo-web.dev"
        vb.memory = 1024
        vb.cpus = 1
    end

    config.vm.provision :docker
    config.vm.provision :docker_compose,
        yml: "/vagrant/docker-compose.yml",
        compose_version: '1.6.2',
        run: "always"

    # Bring up containers
    #config.vm.provision "docker" do |d|
    #    d.build_image "/vagrant", args: "-t 'rails'"
    #    d.run "server", args: "-p 80:3000", image: "rails"
    #end
end
