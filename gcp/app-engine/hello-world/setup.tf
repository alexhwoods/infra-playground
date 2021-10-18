# Enable the Cloud Build API
resource "google_project_service" "project" {
  project = var.project
  service = "cloudbuild.googleapis.com"
}
