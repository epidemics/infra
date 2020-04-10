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

