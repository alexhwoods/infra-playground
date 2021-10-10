variable "location" {
  type    = string
  default = "us-east1"
}

resource "google_kms_key_ring" "key_ring_1" {
  project  = "kms-example-328512"
  name     = "key_ring_1"
  location = var.location
}

resource "google_kms_crypto_key" "symmetric_key_1" {
  name     = "symmetric_key_1"
  key_ring = google_kms_key_ring.key_ring_1.self_link
}

output "key_name" {
  value = google_kms_crypto_key.symmetric_key_1.name
}

output "key_ring" {
  value = google_kms_key_ring.key_ring_1.name
}

output "location" {
  value = var.location
}
