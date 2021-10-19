
# GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project

  enable_autopilot = true

  network    = var.network
  subnetwork = var.subnet

  # depends_on = [
  #   google_project_service.container_api
  # ]
}
