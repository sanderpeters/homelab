terraform {
  required_providers {
    cloudflare = {
      source  = "registry.opentofu.org/cloudflare/cloudflare"
      version = ">= 1.0.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "root" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "A"
  content = var.homelab_ip_address
  proxied = false
}

resource "cloudflare_record" "subdomain" {
  for_each = toset(var.subdomains)
  zone_id  = var.cloudflare_zone_id
  name     = each.value
  type     = "CNAME"
  content  = var.root_domain
  ttl      = 1
  proxied  = false
}
