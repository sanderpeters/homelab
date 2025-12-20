provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}

resource "kubernetes_namespace_v1" "homelab" {
  metadata {
    name = "homelab"
    labels = {
      app = "homelab"
    }
  }
}

resource "kubernetes_limit_range_v1" "homelab_limits" {
  metadata {
    name      = "homelab-limits"
    namespace = kubernetes_namespace_v1.homelab.metadata[0].name
  }

  spec {
    limit {
      default = {
        cpu    = "500m"
        memory = "512Mi"
      }
      default_request = {
        cpu    = "250m"
        memory = "256Mi"
      }
      type = "Container"
    }
  }
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