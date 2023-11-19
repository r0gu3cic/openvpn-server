# modules/droplet/variables.tf

variable "droplet_name" {
  description = "Name of the Droplet"
}

variable "droplet_size" {
  description = "Size of the Droplet"
}

variable "droplet_image" {
  description = "Droplet image"
}

variable "droplet_region" {
  description = "Droplet region"
}

variable "droplet_ipv6" {
  description = "Droplet IPv6 support"
}

variable "droplet_monitoring" {
  description = "Droplet monitoring support"
}

variable "droplet_backups" {
  description = "Droplet backups support"
}

variable "droplet_ssh_keys" {
  description = "SSH key from the DigitalOcean account that will be added to the Droplet for the root user"
}