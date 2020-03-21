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
