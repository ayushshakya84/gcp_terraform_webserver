# **Terraform-GCP-Web**
## **Overview**
This Terraform project automates the deployment of a Google Cloud infrastructure, including Compute Engine instances, a Load Balancer, and a Virtual Network.
## **Requirements**
Ensure you have the following dependencies installed before running Terraform:
- Terraform (>= v1.0)
- Google Cloud SDK (gcloud CLI)
- IAM permissions to create resources in GCP
- Configured GCP authentication (gcloud auth application-default login)
## **Providers**
This project uses the Google Cloud provider:
```
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = "lexical-drake-423604-d4"
  region  = "us-west1"
}
```



