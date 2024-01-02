# environments/internet/compute.tf

# create internet droplet
module "internet_droplet" {
  source = "../../modules/droplet"
  droplet_name = var.internet_droplet_name
  droplet_size = var.internet_droplet_size
  droplet_image = var.internet_droplet_image
  droplet_region = var.internet_droplet_region
  droplet_ipv6 = var.internet_droplet_ipv6
  droplet_monitoring = var.internet_droplet_monitoring
  droplet_backups = var.internet_droplet_backups
  # we can add ssh key that exists on a DigitalOcean account using its fingerprint
  # fingerprint stays the same if we recreate ssh resurce if the ssh key is the same
  # if we create a new, different ssh key we would need to change this fingerprint bellow
  droplet_ssh_keys = var.internet_droplet_ssh_keys
}

# create monitoring alerts
resource "digitalocean_monitor_alert" "internet_cpu_alert" {
  alerts {
    email = [var.admin_email_address]
  }
  description = "CPU usage higher that 70%"
  type        = "v1/insights/droplet/cpu"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [module.internet_droplet.droplet_id]
}
resource "digitalocean_monitor_alert" "internet_disk_alert" {
  alerts {
    email = [var.admin_email_address]
  }
  description = "Disk usage higher that 70%"
  type        = "v1/insights/droplet/disk_utilization_percent"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [module.internet_droplet.droplet_id]
}
resource "digitalocean_monitor_alert" "internet_memory_alert" {
  alerts {
    email = [var.admin_email_address]
  }
  description = "Memory usage higher that 70%"
  type        = "v1/insights/droplet/memory_utilization_percent"
  enabled     = true
  window      = "5m"
  compare     = "GreaterThan"
  value       = 70
  entities    = [module.internet_droplet.droplet_id]
}
# create uptime check for a internet server
resource "digitalocean_uptime_check" "internet_uptime_check" {
  name  = var.internet_uptime_check_name
  type = "ping"
  target = module.internet_droplet.droplet_ipv4
  regions = ["eu_west"]
}
resource "digitalocean_uptime_alert" "internet_uptime_check_alert" {
  name       = var.internet_uptime_check_alert_name
  check_id   = digitalocean_uptime_check.internet_uptime_check.id
  type       = "down"
  period     = "2m"
  notifications {
    email = [var.admin_email_address]
    # there is a option for Slack notification as well
  }
}

resource "null_resource" "check_droplet_stability_and_configure_droplet" {
  # check ssh connection to the droplet
  connection {
    host = module.internet_droplet.droplet_ipv4
    type = "ssh"
    user = "root"
    private_key = file(var.path_to_private_key)
    timeout = "2m"
  }
  # wait for 2 minutes for droplet to become stable
  provisioner "remote-exec" {
    inline = [ 
      "echo Wait for droplet to become stable", 
      "sleep 2m", 
      "echo Droplet should be stable now",
    ]
  }
  # update inventory file with data for new droplet
  provisioner "local-exec" {
    working_dir = var.relative_path_to_ansible
    command = <<-EOT
    #!/bin/bash

    # Remove existing [*_env] block if there is one
    sed -i '/\[${var.ansible_inventory_group}\]/,+1d' ${var.ansible_inventory_file}

    # Update the Ansible inventory file
    echo " " >> ${var.ansible_inventory_file}
    echo "[${var.ansible_inventory_group}]" >> ${var.ansible_inventory_file}
    echo "${var.ansible_inventory_host_alias} ansible_host=${module.internet_droplet.droplet_ipv4}" >> ${var.ansible_inventory_file}
    echo " " >> ${var.ansible_inventory_file}

    # Remove empty lines from the Ansible inventory file
    sed -i '/^\s*$/d' ${var.ansible_inventory_file}
    EOT
  }
  # configure new droplet
  provisioner "local-exec" {
    working_dir = var.relative_path_to_ansible
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook_server_config.yml --extra-vars 'hosts=${var.ansible_inventory_host_alias}' -i ${var.ansible_inventory_file} -u root --private-key ${var.path_to_private_key} --vault-password-file ${var.ansible_vault_pass_file}"
  }
}