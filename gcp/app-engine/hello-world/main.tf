resource "google_app_engine_application" "hello_world_app" {
  project     = var.project
  location_id = var.location
}

resource "google_storage_bucket" "bucket" {
  project = var.project
  name    = "deployed-ae-apps"
}

resource "google_storage_bucket_object" "object" {
  name   = "hello-world.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./app/hello-world.zip"
}

resource "google_app_engine_standard_app_version" "hello_world_app_v1" {
  version_id = "v1"
  service    = "hello-world"
  runtime    = "python39"

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}/${google_storage_bucket_object.object.name}"
    }
  }

  env_variables = {
    port = "8080"
  }

  basic_scaling {
    max_instances = 2
  }

  noop_on_destroy = false
}
