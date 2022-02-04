terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.63.0"
    }
  }
  backend "gcs" {
    bucket = "tfstate-mbk"
    prefix = "terraform/cloud-function-hello-world"
  }
}

provider "google" {
  project = "data-dev-337414"
  region  = "europe-west2"
}

module "scheduled_job" {
  source                   = "./scheduled_job"
  name                     = var.name
  schedule                 = var.schedule
  trigger                  = var.trigger
  storage_trigger_resource = var.storage_trigger_resource
}
