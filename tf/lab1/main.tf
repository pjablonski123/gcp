terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}

/*
terraform {
  backend "gcs" {
    bucket  = "tf-bucket-830313"
    prefix  = "terraform/state"
  }
}
*/
provider "google" {
  version = "3.5.0"
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "instances" {
  source = "./modules/instances"
}

module "storage" {
  source = "./modules/storage"
}

/*
resource "google_compute_firewall" "default" {
  name    = "tf-firewall"
  network = "tf-vpc-31670"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "default" {
  name = "tf-vpc-31670"
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "3.4.0"
  project_id   = var.project_id
  network_name = "VPC Name"
  routing_mode = "GLOBAL"
  
  subnets = [
      {
          subnet_name           = "subnet-01"
          subnet_ip             = "10.10.10.0/24"
          subnet_region         = "us-east1"
      },
      {
          subnet_name           = "subnet-02"
          subnet_ip             = "10.10.20.0/24"
          subnet_region         = "us-east1"
      }
  ]

}*/
