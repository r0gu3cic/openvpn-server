# OpenVPN Server project

This is a automation project where I tried to provision and configure OpenVPN server using Ansible and Terraform.  

## Requirements  

We need Ansible and Terraform installed on a local machine (tested with **Ansible 2.15.2** and **Terraform v1.5.5**).
We also need to have a DigitalOcean account and we need to create an Personal access token for that DigitalOcean account to be able to provision our OpenVPN server, also it is necessary to add an SSH key which will be used for server configuration.  
That SSH key could be added manually or using Terraform.  
To add SSH key to the DigitalOcean account using Terraform we need to specify which key should be added from localhost to the DigitalOcean account in *terraform/main.tf* file and then to move to the *terraform* directory and run following commands  
`terraform init`  
`terraform plan`  
`terraform apply`  
Finally we have to make sure that fingerprint of that SSH key is properly set in *terraform/environments/dev/variables.tf* file before we start with provisioning OpenVPN server, fingerprint could be found on DigitalOcean account where the SSH key is added.  
After that we are all set for next stage, for provisioning and configuring OpenVPN server.  

## OpenVPN server provisioning and configuration

To provision and initially configure OpenVPN server we need to clone this repo, and we need to have a file with vault password (for this contact your DevOps), that *vault_pass.txt* file should be somewhere on the filesystem on local machine, make sure to change path to that file in *terraform/environments/dev/variables.tf* file.  
Finally make sure to go through *terraform/environments/dev/variables.tf*, *ansible/inventory/host_vars/dev_vm/vars.yml* and *ansible/inventory/host_vars/dev_vm/vault.yml* files to check all the variables that will be used for server configuration such as server region, server size, username, sudo password, SSH key for that user and some other tweaks (you know vault pass because DevOps told you :smiley:).  
Lets provision and configure our OpenVPN server.  
Move to the *terraform/environment/dev* directory  
`cd terraform/environments/dev`  
and to use following set of commands  
`terraform init`  
`terraform plan`  
`terraform apply`  
We will be prompted for DigitalOcean Personal access token and confirmation that we know what we are doing :smiley:  
This will create a OpenVPN server hosted on a DigitalOcean droplet on our DigitalOcean account.  
Generally we can tweak our server configuration in *terraform/environments/dev/variables.tf* and *ansible/inventory/host_vars/dev_vm/vars.yml* files as long as we understand what is going on.  

## Client configuration

After provisioning and configuration phase we are all set to create OpenVPN client configurations for our OpenVPN clients. For that all we need is to log in to the OpenVPN server as a sudo user and run python script that will create a configuration file for our new client and then we need to give this configuration file to our client to be able to use VPN services.  
To run the script use following line after you log in to the server as a sudo user  
`./create_client.py <client_common_name>`  
If we want to revoke certificate for certain client we can use another python script  
`./revoke_client.py <client_common_name>`  
To destroy this server we need to change directory to the terraform/environment/dev directory and run following command  
`terraform destroy`  

## Known issues  

## To do  

- [x] Create a python script for client config creation based on the notes  
- [x] Create a python script for client removal  
- [x] Add server monitoring and uptime check on DigitalOcean using Terraform