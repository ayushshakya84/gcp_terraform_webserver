# **Terraform-GCP-Web**
## **Overview**
This Terraform project automates the deployment of a Google Cloud infrastructure, including Compute Engine instances, a Load Balancer, and a Virtual Network.
## **Requirements**
Ensure you have the following dependencies installed before running Terraform:
- Terraform (>= v1.0)
- Google Cloud SDK (`gcloud` CLI)
- IAM permissions to create resources in GCP
- Configured GCP authentication (`gcloud auth application-default login`)
## **Providers**
This project uses the Google Cloud provider:
```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = "Project ID"
  region  = "Region"
}
```
## **Modules**
This project is modularized into three Terraform modules:
1. **Compute Engine** - Manages virtual machine instances and instance groups.
2. **Load Balancer** - Configures HTTP(S) load balancing.
3. **Virtual Network** - Defines the VPC, subnets, and firewall rules.
## **Variables**
The project uses several Terraform variables defined in `variables.tf`. Below are key variable definitions:
- ###  **Compute Engine Instances**
```hcl
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
```
- ###  **Virtual Network (VPC & Subnets)**
```hcl
variable "vpc" {
  description = "Map of VPC configurations"
  type = map(object({
    name                    = string
    auto_create_subnetworks = bool
    mtu                     = number
  }))
}
```
- ###  **Load Balancer Configuration**
```hcl
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
```
## **Main Configuration (`main.tf`)**
The main Terraform configuration defines module sources and passes necessary variables.
```hcl
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
```
## **Terraform Variables Configuration (`terraform.tfvars`)**
The `terraform.tfvars` file provides values for the variables.
Example configuration:
```hcl
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
}

vpc = {
  vpc1 = {
    name                    = "vpc-1"
    auto_create_subnetworks = false
    mtu                     = 1460
  }
}

firewall = {
  firewall1 = {
    name    = "Allow HTTP and HTTPS"
    network = "vpc-1"
    allow = [
      {
        protocol = "tcp"
        ports    = ["80", "443"]
      }
    ]
    target_tags   = ["web"]
    source_ranges = ["49.43.153.244"]
  }
}
```
## **How to Deploy**
### **1. Initialize Terraform**
Run the following command to initialize the working directory:
```sh
terraform init
```
### **2. Plan the Deployment**
Generate and review the execution plan:
```sh
terraform plan
```
### **3. Apply the Configuration**
Apply the changes to deploy resources:
```sh
terraform apply -auto-approve
```
### **4. Destroy the Infrastructure**
To delete all created resources:
```sh
terraform destroy -auto-approve
```

## **Project Structure**
```bash
/terraform-project
│── /modules
│   ├── /compute_engine
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── /virtual_network
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── /load_balancer
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── main.tf
│── variables.tf
│── terraform.tfvars
│── README.md
```
## **Best Practices**
- Use **remote state storage** (e.g., GCS backend) to collaborate in teams.
- Implement **Terraform workspaces** to manage multiple environments (dev, staging, prod).
- Follow the **principle of least privilege (PoLP)** when assigning IAM permissions.
- Use **module versioning** to avoid breaking changes.
## **Contributing**
If you’d like to contribute, please fork the repository and submit a pull request.
