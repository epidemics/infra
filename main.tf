/* Google Cloud Project */
provider "google" {
  version = "~> 3.4.0"
  project = "epidemics-270907"
  region = "us-west1"
  zone = "us-west1-c"
}

provider "google-beta" {
  version = "~> 3.4.0"
  project = "epidemics-270907"
  region = "us-west1"
  zone = "us-west1-c"
}


data "google_project" "epidemics" {
  project_id = "epidemics-270907"
}

provider "kubernetes" {
  version = "~> 1.10.0"
  alias = "epidemics"

  host = "https://${google_container_cluster.epidemics.endpoint}"
  token = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.epidemics.master_auth[0].cluster_ca_certificate)
}


resource "google_container_cluster" "epidemics" {
  provider = google-beta
  initial_node_count = 0
  location = "us-west1-c"
  name = "epidemics"
  project = "epidemics-270907"
  network = "projects/epidemics-270907/global/networks/default"
  subnetwork = "projects/epidemics-270907/regions/us-west1/subnetworks/default"

  remove_default_node_pool = true
  ip_allocation_policy {
    cluster_secondary_range_name = "gke-epidemics-pods-2995938f"
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
  project = "epidemics-270907"

  cluster = google_container_cluster.epidemics.name
  depends_on = [
    google_container_cluster.epidemics]
  initial_node_count = 3
  name = "default-preempt"
  node_locations = [
    "us-west1-c",
  ]

  autoscaling {
    max_node_count = 5
    min_node_count = 0
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb = 100
    disk_type = "pd-standard"
    image_type = "COS"
    local_ssd_count = 0
    machine_type = "n1-standard-1"
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
    preemptible = true
    service_account = "default"

  }

  upgrade_settings {
    max_surge = 1
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
