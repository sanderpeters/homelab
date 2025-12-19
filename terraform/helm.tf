provider "helm" {
  kubernetes {
    config_path = "${path.module}/config/kube.yaml"
  }
}