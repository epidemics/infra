resource "google_container_cluster" "epidemics" {
  provider           = google-beta
  initial_node_count = 0
  location           = "us-west1-c"
  name               = "epidemics"
  project            = "epidemics-270907"
  network            = "projects/epidemics-270907/global/networks/default"
  subnetwork         = "projects/epidemics-270907/regions/us-west1/subnetworks/default"

  remove_default_node_pool = true
  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-epidemics-pods-2995938f"
    services_secondary_range_name = "gke-epidemics-services-2995938f"
  }

  release_channel {
    channel = "REGULAR"
  }
  lifecycle {
    ignore_changes = [
      master_auth,
      network,
      subnetwork,
      node_config,
    ]
    # Terraform bugs, should be fixed in 0.12
  }

}


resource "google_container_node_pool" "default-preempt" {
  provider = google-beta
  location = "us-west1-c"
  project  = "epidemics-270907"

  cluster = google_container_cluster.epidemics.name
  depends_on = [
  google_container_cluster.epidemics]
  initial_node_count = 3
  name               = "default-preempt"
  node_locations = [
    "us-west1-c",
  ]

  autoscaling {
    max_node_count = 10
    min_node_count = 0
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb    = 100
    disk_type       = "pd-standard"
    image_type      = "COS"
    local_ssd_count = 0
    machine_type    = "n1-standard-1"
    metadata = {
      "disable-legacy-endpoints" = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
    preemptible     = true
    service_account = "default"

  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}

resource "kubernetes_namespace" "staging" {
  metadata {
    name = "staging"
  }
}

resource "kubernetes_namespace" "production" {
  metadata {
    name = "production"
  }
}

resource "google_compute_network" "default-network" {
  name                            = "default"
  delete_default_routes_on_create = false
  auto_create_subnetworks         = true
  routing_mode                    = "REGIONAL"
  description                     = "Default network for the project"
}
