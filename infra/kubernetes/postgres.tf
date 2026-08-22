resource "random_password" "postgres_superuser_password" {
  length  = 32
  special = false
}

resource "kubernetes_secret_v1" "postgres_credentials" {
  metadata {
    name      = "postgres-credentials"
    namespace = "postgres"
  }

  data = {
    POSTGRES_PASSWORD    = random_password.postgres_superuser_password.result
    KEYCLOAK_DB_PASSWORD = random_password.keycloak_db_password.result
    JOURNIV_DB_PASSWORD  = random_password.journiv_db_password.result
  }

  type = "Opaque"
}
