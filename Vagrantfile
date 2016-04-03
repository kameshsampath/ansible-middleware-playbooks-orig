# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "kameshsampath/centos7x"

  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__auto: true

  # JON Server and PostgreSQL
   config.vm.define "jon", primary: true do |node|
     node.vm.box         = "kameshsampath/centos7x"
     node.vm.hostname    = "jon.example.com"      
     node.vm.network "private_network", ip: "192.168.56.198"
             
     node.vm.provider :virtualbox do |vb|
        vb.name    = "JON_and_PostgreSQL"
        vb.memory  =  2048
        vb.cpus    =   1 
     end
   end

  # EWS - Enterprise Web Server
   config.vm.define "ews", primary: true do |node|
     node.vm.box         = "kameshsampath/centos7x"
     node.vm.hostname    = "ews.example.com"      
     node.vm.network "private_network", ip: "192.168.56.199"
             
     node.vm.provider :virtualbox do |vb|
        vb.name    = "JBoss Web Server"
        vb.memory  =  1024
        vb.cpus    =   1 
     end
   end

  # EAP Nodes
  (1..3).each do | i |
    config.vm.define "eap-node-#{i}" do |node|
      node.vm.box         = "kameshsampath/centos7x"
      node.vm.hostname    = "eap-node-#{i}.example.com"      
      node.vm.network "private_network", ip: "192.168.56.20#{i}"
           
      node.vm.provider :virtualbox do |vb|
        vb.name    = "EAP_Node#{i}"
        vb.memory  =  1024
        vb.cpus    =   1 
      end
    end
  end

  #Vagrant Cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    # http://fgrehm.viewdocs.io/vagrant-cachier/usage/
    # config.cache.scope="box"
    config.cache.scope = :machine
    config.cache.enable :yum
  end

  #Vagrant vb-guest
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.cache.enable :yum
    config.vbguest.no_remote = true
  end
  
end  
