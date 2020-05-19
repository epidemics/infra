data "google_iam_policy" "admin" {
  binding {
    members = [
      "serviceAccount:${google_service_account.terraform.email}",
      "user:kotrfa@gmail.com",
      "user:gavento@gmail.com",
      "user:maksym.balatsko@blindspot.ai",
      "user:jakub.smid@blindspot.ai",
    ]
    role = "roles/owner"
  }
  binding {
    members = [
      "serviceAccount:657183051434-compute@developer.gserviceaccount.com",
      "serviceAccount:657183051434@cloudservices.gserviceaccount.com",
      "serviceAccount:service-657183051434@containerregistry.iam.gserviceaccount.com",
      "user:berykubik@gmail.com",
      "user:Gajdova.Anna@gmail.com",
      "user:jacobklagerros@gmail.com",
      "user:michal.jezku@gmail.com",
      "user:vesely.v4@gmail.com",
      "user:jeromezng@gmail.com",
      "user:mathijs.henquet@gmail.com",
      "user:lu.nemec@gmail.com",
      "user:wolverton.jr@gmail.com",
    ]
    role = "roles/editor"
  }
  binding {
    members = [
      "user:pfduc87@gmail.com",
    ]
    role = "roles/viewer"
  }
  binding {
    members = [
      "serviceAccount:${google_service_account.github-actions.email}"
    ]
    role = "roles/storage.admin"
  }
  binding {
    members = [
      "serviceAccount:${google_service_account.github-actions.email}"
    ]
    role = "roles/compute.admin"
  }
  binding {
    members = [
      "serviceAccount:service-657183051434@compute-system.iam.gserviceaccount.com",
    ]
    role = "roles/compute.serviceAgent"
  }
  binding {
    members = [
      "serviceAccount:service-657183051434@gcp-sa-computescanning.iam.gserviceaccount.com",
    ]
    role = "roles/computescanning.serviceAgent"
  }
  binding {
    members = [
      "serviceAccount:${google_service_account.github-actions.email}"
    ]
    role = "roles/container.admin"
  }
  binding {
    members = [
      "serviceAccount:service-657183051434@container-engine-robot.iam.gserviceaccount.com",
    ]
    role = "roles/container.serviceAgent"
  }
  binding {
    members = [
      "serviceAccount:service-657183051434@container-analysis.iam.gserviceaccount.com",
    ]
    role = "roles/containeranalysis.ServiceAgent"
  }

  binding {
    members = [
      "serviceAccount:service-657183051434@gcp-sa-osconfig.iam.gserviceaccount.com",
    ]
    role = "roles/osconfig.serviceAgent"
  }
}

resource "google_project_iam_policy" "epidemics" {
  project     = data.google_project.epidemics.project_id
  policy_data = data.google_iam_policy.admin.policy_data
}


resource "google_service_account" "github-actions" {
  account_id   = "github-actions"
  display_name = "github-actions"
}


resource "google_service_account" "terraform" {
  account_id   = "onwer-tf"
  display_name = "onwer-tf"
}
