terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "=5.13.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "=5.14.0"
    }
  }
}
provider "google" {
  project        = var.project_id
  region         = var.region
  default_labels = var.default_labels

}
provider "google-beta" {
  project        = var.project_id
  region         = var.region
  default_labels = var.default_labels
}
