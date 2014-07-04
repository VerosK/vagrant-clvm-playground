# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.hostmanager.enabled = false

  config.vm.box = "centos-6.x-64bit-puppet.3.x"
  config.vm.box_url = "http://packages.vstone.eu/vagrant-boxes/centos-6.x-64bit-latest.box"

  # create two boxen
  for boxname in ['left','right'] do

      config.vm.define boxname do |box|

          box.vm.hostname = boxname+".testbed"

          box.vm.provider "virtualbox" do |vb|
            vb.gui = true

            # Add memory
            vb.customize ["modifyvm", :id, "--memory", "1024"]

            # create shared disk
            vb.customize ["createhd", "--filename", 'second.vdi', "--size", "2048", '--variant', 'fixed']
            vb.customize ["modifyhd", 'second.vdi', "--type", "shareable"]

            # connect the disk to SATA port 4
            vb.customize ["storageattach", :id, '--storagectl', 'SATA Controller',
                    '--port', 4, '--device', 0, '--type', 'hdd',
                    '--medium', 'second.vdi']

            # Set serial and model number to the disk
            vb.customize ["setextradata", :id,
                "VBoxInternal/Devices/ahci/0/Config/Port4/SerialNumber",
                "shared"]
            vb.customize ["setextradata", :id,
                "VBoxInternal/Devices/ahci/0/Config/Port4/ModelNumber",
                "VIRTUAL"]
          end

          config.vm.provision "puppet" do |puppet|
            puppet.manifests_path = "manifests"
            puppet.manifest_file  = "site.pp"
            puppet.module_path = ['modules']
          end
    end
  end
end
