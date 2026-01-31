variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "homelab_ip_address" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "root_domain" {
  type = string
}

variable "subdomains" {
  type = list(string)
}