

resource "google_kms_crypto_key" "asymmetric_signing_key" {
  name     = "asymmetric_signing_key"
  key_ring = google_kms_key_ring.key_ring_1.self_link
  purpose  = "ASYMMETRIC_SIGN"

  version_template {
    algorithm = "EC_SIGN_P256_SHA256" # The recommended one https://cloud.google.com/kms/docs/algorithms#elliptic_curve_signing_algorithms
  }
}

data "google_kms_crypto_key_version" "asymmetric_signing_key_version" {
  crypto_key = google_kms_crypto_key.asymmetric_signing_key.id
}

output "asymmetric_signing_key_name" {
  value = google_kms_crypto_key.asymmetric_signing_key.name
}

output "asymmetric_signing_key_version" {
  value = data.google_kms_crypto_key_version.asymmetric_signing_key_version.version

  depends_on = [
    google_kms_crypto_key.asymmetric_signing_key
  ]
}
