variable "location" {
  type    = string
  default = "us-east1"
}

resource "google_kms_key_ring" "key_ring_1" {
  project  = "kms-example-328512"
  name     = "key_ring_1"
  location = var.location
}

output "location" {
  value = var.location
}

output "key_ring" {
  value = google_kms_key_ring.key_ring_1.name
}

