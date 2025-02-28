terraform {
  backend "gcs" {
    bucket  = "apigee-state-bucket" #create the bucket in GCP console
    prefix  = "infrastructure/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "my_bucket" {
  name     = var.bucket_name
  location = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}