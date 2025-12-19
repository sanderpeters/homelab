provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "root" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "A"
  content   = var.homelab_ip_address
  proxied = true
}

resource "cloudflare_record" "subdomain" {
  for_each = toset(["deluge", "cockpit"])
  zone_id = var.cloudflare_zone_id
  name    = each.value
  type    = "CNAME"
  content   = "@"
  ttl     = 1
  proxied = true
}
