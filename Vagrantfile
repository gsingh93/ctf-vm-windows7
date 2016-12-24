# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "windows_7"
    config.vbguest.auto_update = false

    config.vm.communicator = "winrm"
    config.winrm.username = "vagrant"
    config.winrm.password = "vagrant"

    config.vm.provision :shell, :path => "provision.ps1"

    # Optionally mount a folder containing the CTF problems
    ctf_path = ENV['CTF_PATH']
    if ctf_path
      config.vm.synced_folder ctf_path, "C:/Users/vagrant/ctf"
    end

    config.vm.provider :virtualbox do |v, override|
      v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    end
end
