# this is where we reference data exported in module definition
# we can reference data under the defined name droplet_ipv4 inside module definition
output "droplet_ipv4" {
    description = "IPv4 address of a new droplet"
    value = module.dev_droplet.droplet_ipv4
}
output "droplet_id" {
    description = "ID of a new droplet"
    value = module.dev_droplet.droplet_id
}