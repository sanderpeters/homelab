locals {
  login_hostname = "${var.login_subdomain}.${var.root_domain}"
}

module "cloudflare" {
  source             = "./cloudflare"
  api_token          = var.cloudflare_api_token
  zone_id            = var.cloudflare_zone_id
  homelab_ip_address = var.homelab_ip_address
  root_domain        = var.root_domain
  subdomains         = ["argocd", "journal", var.login_subdomain]
  login_hostname     = local.login_hostname
}

module "kubernetes" {
  source               = "./kubernetes"
  cloudflare_api_token = var.cloudflare_api_token
}

module "keycloak" {
  source         = "./keycloak"
  admin_username = module.kubernetes.keycloak_bootstrap_admin_username
  admin_password = module.kubernetes.keycloak_bootstrap_admin_password
  keycloak_url   = "https://${local.login_hostname}"
}
