# Ansible JBoss Middleware

## Purpose

This repository provides a set of generic roles and reusable playbooks for deploying JBoss Middleware and associated CI / CD tooling.  The playbooks supports the provisoning the following products,

* JBoss Enterprise Application Platform 
* JBoss Operations Network
* JBoss Enterprise Web Server

## Playbook Directory Layout

The repository is organized as follows,

*  `provisioning` - this folder consist of all roles that can be provisioned using Ansible, all subfolders within this folder are organized using Ansible inventory folder style, for more information refer to [Intro to Inventory](http://docs.ansible.com/ansible/intro_inventory.html) and [Playbook Best Practices](http://docs.ansible.com/ansible/playbooks_best_practices.html)

* `softwares` - this folder will hold all the softwares that will be used by the playbooks in provisioning various softwares without going to internet.
An example to provision a EAP on Domain mode with JON and EWS, the software folder will hold the following softwares,
	<ul>
	<li>apache-maven-3.3.9-bin.tar.gz</li>
	<li>jboss-eap-6.4.0-installer.jar</li>
	<li>jboss-eap-6.4.5-patch.zip</li>
	<li>jboss-eap-native-6.4.0-RHEL7-x86_64.zip</li>
	<li>jboss-ews-httpd-2.1.0-RHEL7-x86_64.zip</li>
	<li>jon-plugin-pack-eap-3.3.0.GA.zip</li>
	<li>jon-plugin-pack-ews-3.3.0.GA.zip</li>
	<li>jon-server-3.3.0.GA.zip</li>
	<li>jws-application-servers-3.0.2-RHEL7-x86_64.zip</li>
	<li>jws-httpd-3.0.2-RHEL7-x86_64.zip</li>
	<li>rhq-enterprise-agent-4.12.0.JON330GA.jar</li>
	</ul>

* `scripts` - this folder will hold all the scripts that will be used for provisioning `vagrant` boxes for test and demo purposes, typically testing all the playbooks works fine before actual deployment

## Playbook Anatomy
The following are the plays that are available as part of this repository,
 
### Variables
The variables that are internally used within the playbooks and roles are defined in [vars](provisioning/vars), the typical pattern for the roles related variable is `<role_name>_vars.yml`, e.g all EAP related variables are defined in [eap_vars.yml](vars/eap_vars.yml)

### Inventory 
The inventory controlled by this playbook is defined in the [inventory](provisioning/inventory) 

### Plays
* [firewall.yml](provisioning/firewall.yml) - this play will perform firewall tasks from role [firewall](provisioning/roles/firewall) e.g. stop/start firewall, open firewall ports, selinux settings
*  [eap.yml](provisioning/eap.yml) - this play will perform EAP installation tasks from role [firewall](provisioning/roles/eap)
* [ews.yml](provisioning/ews.yml) - this play will perform EWS installation tasks from role [firewall](provisioning/roles/ews)
* [jon.yml](provisioning/jon.yml) - this play will perform typical firewall tasks from role [firewall](provisioning/roles/jon)
*  [services.yml](provisioning/services.yml) - this play will perform typical service tasks for the nodes, e.g. service creation for EAP, start/stop/restart services [firewall](provisioning/roles/services) <br/>
The above plays will use one or more roles internally based on the need 
 - [java](provisioning/roles/java) - install java and related tools e.g. maven
 - [pgsql](provisioning/roles/pgsql) - install PostgreSql database 

## Provisioning the Vagrant box

The [Vagrantfile](Vagrantfile) can be used to build a demo machine with EAP on domain/standalone mode along with JON, EWS , the steps to provision are,

* Download required softwares to the $PROJECT_HOME/softwares folder

* `vagrant up` - this will bring up the vagrant machines one for *EWS* , three *EAP* nodes and one *JON* node

Tweak `vagrantfile` to suit the required environment.

Provisioning command

> $ ansible-playbook -i provisioning/inventory [all|db|eap|ews| eap-master|eap-slaves] play_name

where `play_name` is one from the list of [Plays](#plays) defined above

e.g. to run firewall playbooks on all nodes

> $  ansible-playbook -i provisioning/inventory all firewall.yml

## WIP
The following are the currently identified improvements,

 - Reorganising the inventory with `group_vars` and `host_vars` in place of flat [inventory](provisioning/inventory)  

## License 
[LICENSE](LICENSE)

----------


## Relevant Links

[Ansible roles](http://docs.ansible.com/ansible/playbooks_roles.html/ "Ansible Roles")