provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "Default"
}

resource "kubernetes_secret" "anubis_key" {
  metadata {
    name      = "anubis-key"
    namespace = "homelab"
  }

  data = {
    ED25519_PRIVATE_KEY_HEX = var.anubis_private_key
  }

  type = "Opaque"
}

resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = "cert-manager"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}

resource "kubernetes_secret" "transmission_auth" {
  metadata {
    name      = "transmission-auth"
    namespace = "homelab"
  }

  data = {
    username = var.transmission_username
    password = var.transmission_password
  }

  type = "Opaque"
}