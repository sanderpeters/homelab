output "keycloak_bootstrap_admin_username" {
  value     = "admin"
  sensitive = true
}

output "keycloak_bootstrap_admin_password" {
  value     = random_password.keycloak_bootstrap_admin_password.result
  sensitive = true
}
