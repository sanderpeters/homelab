resource "random_password" "mariadb_root_password" {
  length  = 32
  special = false
}

resource "random_password" "keycloak_db_password" {
  length  = 32
  special = false
}

resource "random_password" "keycloak_bootstrap_admin_password" {
  length  = 32
  special = false
}

resource "kubernetes_secret_v1" "mariadb_credentials" {
  metadata {
    name      = "mariadb-credentials"
    namespace = "mariadb"
  }

  data = {
    MARIADB_ROOT_PASSWORD = random_password.mariadb_root_password.result
    MARIADB_DATABASE      = "keycloak"
    MARIADB_USER          = "keycloak"
    MARIADB_PASSWORD      = random_password.keycloak_db_password.result
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "keycloak_db_credentials" {
  metadata {
    name      = "keycloak-db-credentials"
    namespace = "keycloak"
  }

  data = {
    username = "keycloak"
    password = random_password.keycloak_db_password.result
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "keycloak_bootstrap_admin" {
  metadata {
    name      = "keycloak-bootstrap-admin"
    namespace = "keycloak"
  }

  data = {
    username = "admin"
    password = random_password.keycloak_bootstrap_admin_password.result
  }

  type = "Opaque"
}
