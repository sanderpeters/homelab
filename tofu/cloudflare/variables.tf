variable "api_token" {
  type      = string
  sensitive = true
}

variable "homelab_ip_address" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "root_domain" {
  type = string
}

variable "subdomains" {
  type = map(object({
    name    = string
    proxied = optional(bool, true)
  }))
  default = {}
}