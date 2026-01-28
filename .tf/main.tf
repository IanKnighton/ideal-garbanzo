terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  # You can remove this if you don't want to use GCS for remote state
  # This is crucial if you plan on deploying Terraform via GitHub Actions
  backend "gcs" {
    bucket = "terraform-gcs-state-storage-ik" # TODO: Update bucket name
    prefix = "ideal-garbanzo/state"           # TODO: Update prefix
  }
}

provider "google" {
  project = var.default_project
  region  = var.default_region
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}
