resource "random_password" "journiv_db_password" {
  length  = 32
  special = false
}

resource "random_password" "journiv_secret_key" {
  length  = 64
  special = false
}

resource "kubernetes_secret_v1" "journiv_db_credentials" {
  metadata {
    name      = "journiv-db-credentials"
    namespace = "journiv"
  }

  data = {
    username = "journiv_user"
    password = random_password.journiv_db_password.result
  }

  type = "Opaque"
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
