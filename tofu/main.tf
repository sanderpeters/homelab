module "cloudflare" {
  source             = "./cloudflare"
  api_token          = var.cloudflare_api_token
  zone_id            = var.cloudflare_zone_id
  homelab_ip_address = var.homelab_ip_address
  root_domain        = var.root_domain
  subdomains         = ["argocd", "download", "watch"]
}

module "kubernetes" {
  source               = "./kubernetes"
  cloudflare_api_token = var.cloudflare_api_token
}