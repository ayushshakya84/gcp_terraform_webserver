resource "google_compute_network" "vpc_network" {
  for_each                = var.vpc
  name                    = each.value.name
  auto_create_subnetworks = each.value.auto_create_subnetworks
  mtu                     = each.value.mtu
}

resource "google_compute_subnetwork" "subnetwork" {
  for_each      = var.subnetwork
  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = each.value.network
}

resource "google_compute_firewall" "firewall" {
  for_each = var.firewall
  name     = replace(lower(each.value.name), " ", "-")
  network  = each.value.network
  dynamic "allow" {
    for_each = each.value.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
  target_tags   = each.value.target_tags
  source_ranges = each.value.source_ranges
}