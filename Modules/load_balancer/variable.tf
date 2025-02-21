variable "global_address" {
  description = "Map of global address configurations"
  type = map(object({
    name = string
  }))
}

variable "http_health_check" {
  description = "Map of http health check configurations"
  type = map(object({
    name                = string
    request_path        = string
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
  }))
}

variable "backend_service" {
  description = "Map of backend service configurations"
  type = map(object({
    name                  = string
    protocol              = string
    health_checks         = list(string)
    load_balancing_scheme = string
    backend = list(object({
      group = string
    }))
  }))
}

variable "url_map" {
  description = "Map of url map configurations"
  type = map(object({
    name            = string
    default_service = string
  }))
}

variable "target_http_proxy" {
  description = "Map of target http proxy configurations"
  type = map(object({
    name    = string
    url_map = string
  }))
}

variable "global_forwarding_rule" {
  description = "Map of global forwarding rule configurations"
  type = map(object({
    name       = string
    target     = string
    port_range = string
  }))
}