resource "cloudflare_ruleset" "zone_custom_firewall" {
  zone_id     = var.zone_id
  name        = "default"
  description = "Custom firewall rules"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action = "skip"
    action_parameters {
      ruleset = "current"
    }
    expression  = "(http.host eq \"${var.login_hostname}\")"
    description = "Skip zone-wide challenge/threat rules for Keycloak - it needs to accept unchallenged server-to-server OIDC/admin API requests"
  }

  rules {
    action      = "block"
    expression  = "(cf.threat_score gt 14)"
    description = "Block high threat score"
  }

  rules {
    action      = "managed_challenge"
    expression  = "true"
    description = "Challenge all visitors with Managed Challenge"
  }
}