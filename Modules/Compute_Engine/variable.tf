variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    name             = string
    machine_type     = string
    boot_disk_image  = string
    boot_disk_type   = string
    zone             = string
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