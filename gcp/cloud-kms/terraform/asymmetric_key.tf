

resource "google_kms_crypto_key" "asymmetric_key_1" {
  name     = "asymmetric_key_1"
  key_ring = google_kms_key_ring.example_key_ring.self_link
  purpose  = "ASYMMETRIC_DECRYPT"

  version_template {
    algorithm = "RSA_DECRYPT_OAEP_2048_SHA256"
  }
}

data "google_kms_crypto_key_version" "asymmetric_key_1_version" {
  crypto_key = google_kms_crypto_key.asymmetric_key_1.id
}

output "asymmetric_key_name" {
  value = google_kms_crypto_key.asymmetric_key_1.name
}

output "asymmetric_key_version" {
  value = data.google_kms_crypto_key_version.asymmetric_key_1_version.version
}


