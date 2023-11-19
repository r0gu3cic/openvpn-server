# modules/droplet/main.tf

# "this" is just a local terraform name of a resource for reference
# it is usualy used for output block reference
# "this" should be used as a name if there will be only one such resource
resource "digitalocean_droplet" "this" {
  name  = var.droplet_name
  size  = var.droplet_size
  image = var.droplet_image
  region = var.droplet_region
  ipv6 = var.droplet_ipv6
  monitoring = var.droplet_monitoring
  backups = var.droplet_backups
  ssh_keys = var.droplet_ssh_keys
}

