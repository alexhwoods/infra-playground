resource "google_kms_key_ring" "example_key_ring" {
  project  = var.project
  name     = "example_key_ring"
  location = var.location
}

output "location" {
  value = var.location
}

output "key_ring" {
  value = google_kms_key_ring.example_key_ring.name
}

