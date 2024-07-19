terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.38.0"
    }
  }
}

provider "google" {
    credentials = "./keys/my-creds.json"
  project = "gothic-gradient-429701-f9"
  region  = "us-central1"
}

resource "google_storage_bucket" "auto-expire" {
  name          = "gothic-gradient-429701-f9-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}