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

resource "kubernetes_secret" "repository" {
  metadata {
    name      = "repo"
    namespace = "argocd"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    url  = "https://github.com/sanderpeters/homelab"
    type = "git"
  }

  type = "Opaque"
}