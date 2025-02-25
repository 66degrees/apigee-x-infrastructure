terraform {
  backend "gcs" {
    bucket  = "apigee-state-bucket" #create the bucket in GCP console
    prefix  = "infrastructure/state"
  }
}