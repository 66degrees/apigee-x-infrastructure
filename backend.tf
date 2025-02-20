terraform {
  backend "gcs" {
    bucket  = "terraform-state-nonprod" #create the bucket in GCP console
    prefix  = "infrastructure/state"
  }
}