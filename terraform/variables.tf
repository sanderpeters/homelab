variable "helm_charts" {
  type = list(string)
  default = ["deluge"]
}

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