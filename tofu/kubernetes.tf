provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "Default"
}

resource "random_string" "anubis_key" {
  length  = 64
  special = false
}

resource "kubernetes_secret" "anubis_key" {
  metadata {
    name      = "anubis-key"
    namespace = "homelab"
  }

  data = {
    ED25519_PRIVATE_KEY_HEX = random_string.anubis_key.result
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

resource "random_string" "transmission_username" {
  length  = 32
  special = false
}

resource "random_string" "transmission_password" {
  length  = 32
  special = true
}

resource "kubernetes_secret" "transmission_auth" {
  metadata {
    name      = "transmission-auth"
    namespace = "homelab"
  }

  data = {
    username = random_string.transmission_username.result
    password = random_string.transmission_password.result
  }

  type = "Opaque"
}