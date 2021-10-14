resource "google_kms_crypto_key" "symmetric_key_1" {
  name     = "symmetric_key_1"
  key_ring = google_kms_key_ring.example_key_ring.self_link
}

output "symmetric_key_name" {
  value = google_kms_crypto_key.symmetric_key_1.name
}
