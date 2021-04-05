# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"

  config.vm.define "server" do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.hostname = "server"
  end

  config.vm.define "database" do |database|
    database.vm.box = "ubuntu/xenial64"
    database.vm.hostname = "database"
  end

  config.vm.define "frontend" do |frontend|
    frontend.vm.box = "ubuntu/xenial64"
    frontend.vm.hostname = "frontend"
  end

  config.vm.define "proxy" do |proxy|
    proxy.vm.box = "ubuntu/xenial64"
    proxy.vm.hostname = "proxy"
  end

end
