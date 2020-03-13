/* Google Cloud Project */
provider "google" {
  version = "~> 3.4.0"
  project = "epidemics-270907"
  region  = "us-west1"
  zone    = "us-west1-c"
}

provider "google-beta" {
  version = "~> 3.4.0"
  project = "epidemics-270907"
  region  = "us-west1"
  zone    = "us-west1-c"
}


data "google_project" "epidemics" {
  project_id = "epidemics-270907"
}

provider "kubernetes" {
  version = "~> 1.10.0"
  alias   = "epidemics"

  host                   = "https://${google_container_cluster.epidemics.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.epidemics.master_auth[0].cluster_ca_certificate)
}

