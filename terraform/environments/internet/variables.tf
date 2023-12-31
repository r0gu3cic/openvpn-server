# environments/internet/variables.tf

# module internet_droplet variables
variable "internet_droplet_name" {
  description = "Name of the Droplet"
  default = "openvpn-internet-droplet"
}

variable "internet_droplet_size" {
  description = "Size of the Droplet"
  default = "s-1vcpu-1gb"
}

variable "internet_droplet_image" {
  description = "Droplet image"
  default = "ubuntu-22-04-x64"
}

variable "internet_droplet_region" {
  description = "Droplet region"
  default = "nyc1"
}

variable "internet_droplet_ipv6" {
  description = "Droplet IPv6 support"
  default = true
}

variable "internet_droplet_monitoring" {
  description = "Droplet monitoring support"
  default = true
}

variable "internet_droplet_backups" {
  description = "Droplet backups support"
  default = false
}

variable "internet_droplet_ssh_keys" {
  description = "SSH key from the DigitalOcean account that will be added to the Droplet for the root user"
  default = ["fb:c5:cd:14:99:5d:69:e6:56:81:7b:03:ec:8e:34:83"]
}

# variables for monitoring alerts
# this email has to be verified on a DigitalOcean account, there could be errors if it is not
variable "admin_email_address" {
  description = "This is a email address for DigitalOcean notification about droplet resource usage, this email has to be verified with the DigitalOcean account"
  default = "stosic.n.stefan@gmail.com"
}
variable "internet_uptime_check_name" {
  description = "This is the name of a Uptime check on DigitalOcean"
  default = "OpenVPN internet server ping check from EU"
}
variable "internet_uptime_check_alert_name" {
  description = "This is the name of a Uptime check alert on DigitalOcean"
  default = "OpenVPN internet server unreachable"
}

# variables for checking droplet stability and for droplet configuration
variable "path_to_private_key" {
  description = "Path to the private key on localhost used for configuring the Droplet"
  default = "~/.ssh/ansible_root_configuration"
}

variable "relative_path_to_ansible" {
  description = "Relative path from the internet environment Terraform module to the Ansible configuration code"
  default = "../../../ansible/"
}

variable "ansible_inventory_file" {
  description = "Reference to the Ansible inventory file, relative path to the inventory file"
  default = "inventory/openvpn_machines.ini"
}

variable "ansible_inventory_group" {
  description = "Group name used in Ansible inventory"
  default = "internet_env" 
}

variable "ansible_inventory_host_alias" {
  description = "Host alias used in Ansible inventory for the Droplet"
  default = "internet_vm" 
}

variable "ansible_vault_pass_file" {
  description = "Reference to the Ansible vault password file, absolute path to the vault password file"
  default = "/home/stefan/repos/openvpn-server/vault_pass.txt"
}