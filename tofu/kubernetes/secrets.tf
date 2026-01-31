resource "random_bytes" "anubis_key" {
  length = 32
}

resource "kubernetes_secret" "anubis_key" {
  metadata {
    name      = "anubis-key"
    namespace = "homelab"
  }

  data = {
    ED25519_PRIVATE_KEY_HEX = random_bytes.anubis_key.hex
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

resource "random_password" "deluge_username" {
  length  = 16
  special = false
}

resource "random_password" "deluge_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "deluge_auth" {
  metadata {
    name      = "deluge-auth"
    namespace = "homelab"
  }

  data = {
    username = random_password.deluge_username.result
    password = random_password.deluge_password.result
  }

  type = "Opaque"
}