resource "google_kms_key_ring" "example_key_ring" {
  project  = "kms-example-328512"
  name     = "example_key_ring"
  location = var.location
}

output "location" {
  value = var.location
}

output "key_ring" {
  value = google_kms_key_ring.example_key_ring.name
}

