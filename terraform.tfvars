# Compute Engine Variables
instances = {
  instance1 = {
    name             = "instance-1"
    machine_type     = "n1-standard-1"
    zone             = "us-central1-a"
    boot_disk_image  = "debian-cloud/debian-9"
    boot_disk_type   = "pd-standard"
    boot_disk_size   = 10
    boot_disk_labels = { env = "dev" }
    subnet_id        = "subnet-1"
    tags             = ["web", "dev"]
  }
  instance2 = {
    name             = "instance-2"
    machine_type     = "n1-standard-2"
    zone             = "us-central1-b"
    boot_disk_image  = "debian-cloud/debian-10"
    boot_disk_type   = "pd-ssd"
    boot_disk_size   = 20
    boot_disk_labels = { env = "prod" }
    subnet_id        = "subnet-2"
    tags             = ["web", "prod"]
  }
}

instance_group = {
  instance_group1 = {
    name      = "instance-group-1"
    zone      = "us-central1-a"
    instances = ["instance-1", "instance-2"]
    named_port = {
      name = "http"
      port = 80
    }
  }
}

# Virtual Network Variables
vpc = {
  vpc1 = {
    name                    = "vpc-1"
    auto_create_subnetworks = false
    mtu                     = 1460
  }
}

subnetwork = {
  subnet1 = {
    name          = "subnet-1"
    ip_cidr_range = "192.1.0.0/28"
    region        = "us-central1"
    network       = "vpc-1"
  }
}

firewall = {
  firewall1 = {
    name    = "Allow HTTP and HTTPS"
    network = "vpc-1"
    allow = [
      {
        protocol = "tcp"
        ports    = ["80", "443", "8080"]
      }
    ]
    target_tags   = ["web"]
    source_ranges = ["49.43.153.244"]
  }
}

# Load Balancer Variables
global_address = {
  address1 = {
    name = "address-1"
  }
}

http_health_check = {
  health_check1 = {
    name                = "health-check-1"
    request_path        = "/"
    check_interval_sec  = 1
    timeout_sec         = 1
    healthy_threshold   = 1
    unhealthy_threshold = 1
  }
}

backend_service = {
  backend_service1 = {
    name                  = "backend-service-1"
    protocol              = "HTTP"
    health_checks         = ["health-check-1"]
    load_balancing_scheme = "EXTERNAL"
    backend = [
      {
        group = "instance-group-1"
      }
    ]
  }
}

url_map = {
  url_map1 = {
    name            = "url-map-1"
    default_service = "backend-service-1"
  }
}

target_http_proxy = {
  target_http_proxy1 = {
    name    = "target-http-proxy-1"
    url_map = "url-map-1"
  }
}

global_forwarding_rule = {
  forwarding_rule1 = {
    name       = "forwarding-rule-1"
    target     = "target-http-proxy-1"
    port_range = "80"
  }
}