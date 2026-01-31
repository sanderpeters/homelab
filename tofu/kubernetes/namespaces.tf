resource "kubernetes_namespace_v1" "homelab" {
  metadata {
    name = "homelab"
    labels = {
      app = "homelab"
    }
  }

  lifecycle {
    ignore_changes = all
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

resource "kubernetes_namespace_v1" "tofu" {
  metadata {
    name = "tofu"
  }
}