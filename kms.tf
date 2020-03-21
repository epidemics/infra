resource "google_kms_key_ring" "main" {
  name     = "main"
  location = "us-west1"
}

resource "google_kms_crypto_key" "main-key" {
  name     = "main-key"
  key_ring = google_kms_key_ring.main.id
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.main-key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "user:kotrfa@gmail.com",
  ]
}

resource "google_kms_crypto_key_iam_binding" "crypto_key_decrypter" {
  crypto_key_id = google_kms_crypto_key.main-key.id
  role          = "roles/cloudkms.cryptoKeyDecrypter"

  members = [
    "serviceAccount:${google_service_account.github-actions.email}"
  ]
}
