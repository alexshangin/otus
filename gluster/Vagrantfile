# -*- mode: ruby -*-
# vi: set ft=ruby :

disk_size = 100 # in megabytes
disk_dir = '../vmdisks' # directory where additional disk files are stored
disk_controller = 'IDE' # MacOS. This setting is OS dependent. Details https://github.com/hashicorp/vagrant/issues/8105

Vagrant.configure("2") do |config|
  # Base VM OS configuration.
  config.vm.box = "centos/7"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 256
    v.cpus = 1
  end

  # Define two VMs with static private IP addresses.
  boxes = [
    { :name => "gluster1",
      :ip => "192.168.7.151",
      :disks => {
		    :sata1 => {
          :dfile => 'disk1',
          :size => 250,
          :port => 1
        },
        :sata2 => {
          :dfile => 'disk2',
          :size => 250, # Megabytes
          :port => 2
        }
      }
    },
    { :name => "gluster2",
      :ip => "192.168.7.152",
      :disks => {
		    :sata1 => {
          :dfile => 'disk1',
          :size => 250,
          :port => 1
        },
        :sata2 => {
          :dfile => 'disk2',
          :size => 250, # Megabytes
          :port => 2
        }
      }
   },
    { :name => "gluster3",
      :ip => "192.168.7.153",
      :disks => {
		    :sata1 => {
          :dfile => 'disk1',
          :size => 250,
          :port => 1
        },
        :sata2 => {
          :dfile => 'disk2',
          :size => 250, # Megabytes
          :port => 2
        }
      }
   },
    { :name => "gluster4",
      :ip => "192.168.7.154",
      :disks => {
		    :sata1 => {
          :dfile => 'disk1',
          :size => 250,
          :port => 1
        },
        :sata2 => {
          :dfile => 'disk2',
          :size => 250, # Megabytes
          :port => 2
        }
      }
   }
  ]
  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network "private_network", ip: opts[:ip]

      # Disks and controllers configuration
      needsController = false
      config.vm.provider :virtualbox do |vm|
        opts[:disks].each do |dname, disk_conf|
          file_to_disk = File.join(disk_dir, config.vm.hostname + disk_conf[:dfile] + '.vdi')
          unless File.exist?(file_to_disk)
            vm.customize ['createhd', '--filename', file_to_disk,
                                      '--variant', 'Fixed',
                                      '--size', disk_conf[:size]]
            needsController = true
          end
        end

        if needsController # add controller only if disk files was created
          vm.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
          opts[:disks].each do |dname, disk_conf|
            file_to_disk = File.join(disk_dir, config.vm.hostname + disk_conf[:dfile] + '.vdi')
            vm.customize ['storageattach', :id, '--storagectl', 'SATA',
                                                '--port', disk_conf[:port],
                                                '--device', 0,
                                                '--type', 'hdd',
                                                '--medium', file_to_disk]
          end
        end
    end

      # Provision VMs using Ansible after the last VM is booted.
      if opts[:name] == boxes.last[:name] 
        config.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbooks/provision.yml"
          ansible.inventory_path = "inventory"
          ansible.limit = "all"
        end
      end
    end
  end

end

