terraform {
  backend "gcs" {
    bucket = "lab-gke-se-tf-state"
    prefix = "terraform/development"
  }
}

data "terraform_remote_state" "bootstrap" {
  backend = "gcs"
  config = {
    bucket = "lab-gke-se-tf-state"
    prefix = "terraform/bootstrap"
  }
}

