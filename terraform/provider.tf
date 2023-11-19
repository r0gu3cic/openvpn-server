terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.8.0"
    }
  }
}

variable "do_token" {
    description = "DigitalOcean API token for DigitalOcean account"
}

provider "digitalocean" {
  token = var.do_token
}