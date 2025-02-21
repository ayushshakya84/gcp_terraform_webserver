resource "google_compute_instance" "instance" {
  for_each     = var.instances
  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = each.value.zone

  tags = each.value.tags

  boot_disk {
    initialize_params {
      image  = each.value.boot_disk_image
      type   = each.value.boot_disk_type
      size   = each.value.boot_disk_size
      labels = each.value.boot_disk_labels
    }
  }

  network_interface {
    subnetwork = each.value.subnet_id

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  lifecycle {
    ignore_changes = [tags, metadata]
  }
}

resource "google_compute_instance_group" "instance_group" {
  for_each  = var.instance_group
  name      = each.value.name
  zone      = each.value.zone
  instances = each.value.instances
  dynamic "named_port" {
    for_each = each.value.named_port
    content {
      name = each.value.named_port.name
      port = each.value.named_port.port
    }
  }
}