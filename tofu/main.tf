module "cloudflare" {
  source               = "./cloudflare"
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_zone_id   = var.cloudflare_zone_id
  homelab_ip_address   = var.homelab_ip_address
  root_domain          = var.root_domain
  subdomains           = ["flood", "download", "watch"]
}

module "kubernetes" {
  source               = "./kubernetes"
  cloudflare_api_token = var.cloudflare_api_token
}