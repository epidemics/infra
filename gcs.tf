resource "google_storage_bucket" "static-covid" {
  bucket_policy_only = false
  force_destroy      = false
  location           = "US"
  name               = "static-covid"
  requester_pays     = false
  storage_class      = "STANDARD"

  cors {
    max_age_seconds = 3600
    method = [
      "*",
    ]
    origin = [
      "*",
    ]
    response_header = [
      "*",
    ]
  }
}

resource "google_storage_bucket" "epidemics-covid" {
  bucket_policy_only = false
  force_destroy      = false
  location           = "US"
  name               = "epidemics-covid"
  requester_pays     = false
  storage_class      = "MULTI_REGIONAL"

  cors {
    method          = ["GET", "HEAD"]
    max_age_seconds = 60

    origin = [
      "http://epidemicforecasting.org",
      "http://staging.epidemicforecasting.org",
      "https://epidemicforecasting.org",
      "https://staging.epidemicforecasting.org",
    ]
    response_header = [
      "Content-Type",
    ]
  }
}

