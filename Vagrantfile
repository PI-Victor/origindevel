# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/fedora23"
  config.vm.synced_folder File.join(ENV["GOPATH"] || File.join(ENV["HOME"], "go/"),"/src"), "/data/src/"

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = ENV["ORIGINDEVEL_MEMORY"] || "4096"
    vb.name = "origindevel"
  end
  config.vm.network "private_network", ip: '10.245.2.2'
  config.vm.network "forwarded_port", guest: 80, host: 1080
  config.vm.network "forwarded_port", guest: 443, host: 1443
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8443, host: 8443

  config.vm.provision "shell", inline: <<-SHELL
  sudo dnf install -y python python-dnf \
                      http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                      http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  SHELL

  config.vm.provision :ansible do |ansible|
    ansible.limit = "origindevel"
    ansible.verbose = ENV["ANSIBLE_VERBOSE"] || "vvvv"
    ansible.playbook = "origin-base.yml"
    ansible.inventory_path = "./inventory"
  end

end
