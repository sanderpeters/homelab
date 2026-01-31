terraform {
  required_version = ">= 1.5.0"

  backend "kubernetes" {
    secret_suffix = "state"
    config_path   = "~/.kube/config"
    namespace     = "tofu"
  }
}