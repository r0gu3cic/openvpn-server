# this is where we need to export data from the resource
# under the name droplet_ipv4
# only then could we reference this data from module i guess
output "droplet_ipv4" {
    description = "IPv4 address of a new droplet"
    value = digitalocean_droplet.this.ipv4_address
}

output "droplet_id" {
    description = "ID of a new droplet"
    value = digitalocean_droplet.this.id
}