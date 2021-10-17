resource "google_app_engine_application" "hello_world_app" {
  project     = var.project
  location_id = var.location
}
