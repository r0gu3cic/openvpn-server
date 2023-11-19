# modules/droplet/main.tf

# resource block
resource "digitalocean_ssh_key" "this" {
  name = var.ssh_pub_key_name
  public_key = var.ssh_pub_key_path
}
