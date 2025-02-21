resource "google_compute_global_address" "global_address" {
  for_each = var.global_address
  name     = each.value.name
}

resource "google_compute_http_health_check" "health_check" {
  for_each            = var.http_health_check
  name                = each.value.name
  request_path        = each.value.request_path
  check_interval_sec  = each.value.check_interval_sec
  timeout_sec         = each.value.timeout_sec
  healthy_threshold   = each.value.healthy_threshold
  unhealthy_threshold = each.value.unhealthy_threshold
}

resource "google_compute_backend_service" "backend_service" {
  for_each              = var.backend_service
  name                  = each.value.name
  protocol              = each.value.protocol
  health_checks         = each.value.health_checks
  load_balancing_scheme = each.value.load_balancing_scheme
  dynamic "backend" {
    for_each = each.value.backend
    content {
      group = backend.value.group
    }
  }
}

resource "google_compute_url_map" "url_map" {
  for_each        = var.url_map
  name            = each.value.name
  default_service = each.value.default_service
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  for_each = var.target_http_proxy
  name     = each.value.name
  url_map  = each.value.url_map
}

resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  for_each   = var.global_forwarding_rule
  name       = each.value.name
  target     = each.value.target
  port_range = each.value.port_range
}