terraform {
  required_providers {
    cloudflare = {
      source  = "registry.opentofu.org/cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

resource "cloudflare_record" "root" {
  zone_id = var.zone_id
  name    = "@"
  type    = "A"
  content = var.homelab_ip_address
  proxied = true
}

resource "cloudflare_record" "subdomain" {
  for_each = var.subdomains
  zone_id  = var.zone_id
  name     = each.value.name
  type     = "CNAME"
  content  = var.root_domain
  ttl      = 1
  proxied  = each.value.proxied
}
