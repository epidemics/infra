resource "google_kms_key_ring" "main" {
  name     = "main"
  location = "us-west1"
}

resource "google_kms_crypto_key" "main-key" {
  name     = "main-key"
  key_ring = google_kms_key_ring.main.id
}

# TODO: still can't encrypt via sops
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.main-key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "user:kotrfa@gmail.com",
  ]
}