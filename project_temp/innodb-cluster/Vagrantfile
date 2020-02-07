INTENT_TYPE="internal-net"

MACHINES = {
  :node1 => {
             :box_name => "dmitrylyutenko/mysql8",
             :net => [
                      {ip: '10.10.10.11', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: INTENT_TYPE},
                     ],
             :node_mode => "master",
            },
  :node2 => {
             :box_name => "dmitrylyutenko/mysql8",
             :net => [
                      {ip: '10.10.10.12', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: INTENT_TYPE},
                     ],
             :node_mode => "slave",
            },
  :node3 => {
             :box_name => "dmitrylyutenko/mysql8",
             :net => [
                      {ip: '10.10.10.13', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: INTENT_TYPE},
                     ],
             :node_mode => "slave",
            },
  :"mysql-shell" => {
             :box_name => "dmitrylyutenko/mysql8",
             :net => [
                      {ip: '10.10.10.14', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: INTENT_TYPE},
                      {ip: '10.11.12.14', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "router-net"},
                     ],
            },
  :"mysql-router" => {
             :box_name => "dmitrylyutenko/mysql8",
             :net => [
                      {ip: '10.10.10.10', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: INTENT_TYPE},
                      {ip: '10.11.12.10', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "router-net"},
                     ],
             :forwarded_port => [
                                #   - Read/Write Connections: localhost:6446
                                {guest: 6446, host: 6446},
                                #   - Read/Only Connections: localhost:6447
                                {guest: 6447, host: 6447},
                                #   X protocol connections to cluster:
                                #   - Read/Write Connections: localhost:64460
                                {guest: 64460, host: 64460},
                                #   - Read/Only Connections: localhost:64470
                                {guest: 64470, host: 64470}
                                ]
            },
}


hosts_file="127.0.0.1\tlocalhost\n"

MACHINES.each do |hostname,config|  
  config[:net].each do |ip|
    if ip[:virtualbox__intnet]==INTENT_TYPE
      hosts_file=hosts_file+ip[:ip]+"\t"+hostname.to_s+"\n"
    end
  end
end

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|
        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s
        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        if boxconfig.key?(:forwarded_port)
          boxconfig[:forwarded_port].each do |port|
            box.vm.network "forwarded_port", port
          end
        end
        box.vm.provider "virtualbox" do |v|
          v.memory = 256
        end
        box.vm.provision "shell" do |shell|
          shell.inline = 'echo -e "$1" > /etc/hosts'
          shell.args = [hosts_file]
        end
        box.vm.provision "ansible" do |ansible|
          ansible.verbose = "v"
          ansible.playbook = "ansible/playbook.yml"
          ansible.tags = "all"
          ansible.extra_vars = {
            "mysql_root_password" => "_SecretPass1",
            "mysql_admin_username" => "admin",
            "mysql_admin_password" => "_AdminPassword2",
            "cluster_name" => "clInnoDB"
          }
          if boxname.to_s =~ /node\d/
            var_host = {"var_host" => "node1"}
            ansible.extra_vars[:var_host]=boxname.to_s
          end
        end
    end
  end
end
