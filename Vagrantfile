# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version '>= 1.7.0'

REQUIRED_PLUGINS = %w( vagrant-triggers vagrant-reload )

REQUIRED_PLUGINS.each do |plugin|
  Vagrant.has_plugin?(plugin) || (
    puts 'The ' +  plugin + ' plugin is required. Please install it with: '
    puts '$ vagrant plugin install ' + plugin
    exit
  )
end

VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))
file_to_disk = File.join(VAGRANT_ROOT, 'dockerstorage.vmdk')
ansible_verbosity = ENV['ANSIBLE_VERBOSE'] || 'vvvv'
origin_memory =  ENV['ORIGINDEVEL_MEMORY'] || '4096'
go_path = ENV['GOPATH'] || File.join(ENV['HOME'], 'go/')

Vagrant.configure(2) do |config|
  config.vm.box = 'boxcutter/fedora23'
  config.vm.synced_folder File.join(go_path,'/src'), '/data/src/'

  config.vm.provider 'virtualbox' do |vb|
    # Customize the amount of memory on the VM:
    # unless File.exist?(file_to_disk)
    #   vb.customize ['createhd', '--filename', file_to_disk, '--size', 200 * 1024]
    #   vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
    # end
    vb.memory = origin_memory
    vb.name = 'origindevel'
    vb.cpus = 2
  end

  config.vm.network 'private_network', ip: '10.245.2.2'
  config.vm.network 'forwarded_port', guest: 80, host: 1080
  config.vm.network 'forwarded_port', guest: 443, host: 1443
  config.vm.network 'forwarded_port', guest: 8080, host: 8080
  config.vm.network 'forwarded_port', guest: 8443, host: 8443

  config.vm.provision :shell, inline: <<-SHELL
    sudo dnf install -y python python-dnf
  SHELL

  config.vm.provision :ansible do |ansible|
    ansible.limit = 'origindevel'
    ansible.verbose = ansible_verbosity
    ansible.playbook = 'origin-base.yml'
    ansible.inventory_path = './inventory'
  end

  config.vm.provision :reload

  config.vm.provision :ansible do |ansible|
    ansible.limit = 'origindevel'
    ansible.verbose = ansible_verbosity
    ansible.playbook = 'origin-setup.yml'
    ansible.inventory_path = './inventory'
  end

end
