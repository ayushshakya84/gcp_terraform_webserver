# variable "network_name" {
#   description = "The name of the vpc network"
#   type        = string
# }

# variable "subnetwork_name" {
#   description = "The Name of the Subnetwork"
#   type        = string
# }

# variable "subnetwork_cidr" {
#   description = "The CIDR rage of the subnetwork"
#   type        = string
# }

# variable "region" {
#   description = "The region where the network resources will be created"
#   type        = string
# }

# variable "allow_ports" {
#   description = "List of ports to allow in the firewall"
#   type        = list(string)
#   default     = ["80", "22"]
# }
# variable "source_ip_ranges" {
#   description = "List of ip to allow in the firewall"
#   type        = list(string)
#   default     = ["0.0.0.0/0"]
# }

variable "vpc" {
  description = "Map of vpc configurations"
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
  description = "Map of firewall configurations"
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