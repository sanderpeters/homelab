terraform {
  required_providers {
    keycloak = {
      source  = "registry.opentofu.org/keycloak/keycloak"
      version = "~> 5.9"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = var.admin_username
  password  = var.admin_password
  url       = var.keycloak_url
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "keycloak_realm" "homelab" {
  realm   = "homelab"
  enabled = true
}

resource "keycloak_openid_client" "journiv" {
  realm_id  = keycloak_realm.homelab.id
  client_id = "journiv"
  name      = "Journiv"
  enabled   = true

  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://journal.sanderpeters.cloud/api/v1/auth/oidc/callback",
  ]
}

resource "kubernetes_secret_v1" "journiv_oidc_credentials" {
  metadata {
    name      = "journiv-oidc-credentials"
    namespace = "journiv"
  }

  data = {
    client-secret = keycloak_openid_client.journiv.client_secret
  }

  type = "Opaque"
}
