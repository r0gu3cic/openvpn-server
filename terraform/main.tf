# main.tf 

# ssh_key for the project that will be used on all newly created droplets for ansible configuration
module "ssh_pub_key" {
  source = "./modules/ssh_pub_key"
  ssh_pub_key_name = "ansible-configuration-key"
  ssh_pub_key_path = file("/home/stefan/.ssh/ansible_configuration_key.pub")
}