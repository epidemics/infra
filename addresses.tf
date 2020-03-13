resource "google_compute_global_address" "loadbalance-staging" {
  name         = "loadbalance-staging"
  address      = "34.107.213.88"
  address_type = "EXTERNAL"
}

resource "google_compute_global_address" "loadbalancer" {
  name         = "loadbalancer"
  address      = "34.107.179.11"
  address_type = "EXTERNAL"
}

resource "google_compute_address" "charts-static-staging" {
  name         = "charts-static-staging"
  address_type = "EXTERNAL"
  address      = "35.203.189.186"
  region       = "us-west1"
}

resource "google_compute_address" "charts-static" {
  name         = "charts-static"
  address_type = "EXTERNAL"
  region       = "us-west1"
  address      = "35.197.75.206"
}

resource "google_storage_bucket" "model-data-covid" {
  name          = "model-data-covid"
  location      = "US-WEST1"
  storage_class = "STANDARD"
  force_destroy = true
}