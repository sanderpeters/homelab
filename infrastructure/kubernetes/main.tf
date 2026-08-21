provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_secret_v1" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = "cert-manager"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}

# Requires the journiv namespace to already exist (created by the journiv
# ArgoCD Application's CreateNamespace=true), so gitops must be bootstrapped
# before this can apply successfully.
resource "random_password" "journiv_secret_key" {
  length  = 64
  special = false
}

resource "kubernetes_secret_v1" "journiv_secret_key" {
  metadata {
    name      = "journiv-secret-key"
    namespace = "journiv"
  }

  data = {
    secret-key = random_password.journiv_secret_key.result
  }

  type = "Opaque"
}
