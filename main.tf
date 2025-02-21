module "compute_engine" {
  source = "./Modules/compute_engine"

  instances      = var.instances
  instance_group = var.instance_group
}

module "virtual_network" {
  source     = "./Modules/virtual_network"
  vpc        = var.vpc
  subnetwork = var.subnetwork
  firewall   = var.firewall
}

module "load_balancer" {
  source                 = "./modules/load_balancer"
  global_address         = var.global_address
  http_health_check      = var.http_health_check
  backend_service        = var.backend_service
  url_map                = var.url_map
  target_http_proxy      = var.target_http_proxy
  global_forwarding_rule = var.global_forwarding_rule
}