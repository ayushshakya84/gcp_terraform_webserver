variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    name             = string
    machine_type     = string
    zone             = string
    boot_disk_image  = string
    boot_disk_type   = string
    boot_disk_size   = number
    boot_disk_labels = map(string)
    subnet_id        = string
    tags             = list(string)
  }))
}

variable "instance_group" {
  description = "Map of instance group configurations"
  type = map(object({
    name      = string
    zone      = string
    instances = list(string)
    named_port = object({
      name = string
      port = number
    })
  }))
}

variable "vpc" {
  description = "Map of VPC configurations"
  type = map(object({
    name                    = string
    auto_create_subnetworks = bool
    mtu                     = number
  }))
}

variable "subnetwork" {
  description = "Map of subnetwork configurations"
  type = map(object({
    name          = string
    ip_cidr_range = string
    region        = string
    network       = string
  }))
}

variable "firewall" {
  description = "Map of firewall rules"
  type = map(object({
    name    = string
    network = string
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    target_tags   = list(string)
    source_ranges = list(string)
  }))
}

variable "global_address" {
  description = "Map of global addresses"
  type = map(object({
    name = string
  }))
}

variable "http_health_check" {
  description = "Map of HTTP health checks"
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
  description = "Map of URL maps"
  type = map(object({
    name            = string
    default_service = string
  }))
}

variable "target_http_proxy" {
  description = "Map of target HTTP proxies"
  type = map(object({
    name    = string
    url_map = string
  }))
}

variable "global_forwarding_rule" {
  description = "Map of global forwarding rules"
  type = map(object({
    name       = string
    target     = string
    port_range = string
  }))
}
