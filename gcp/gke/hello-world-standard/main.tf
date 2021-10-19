variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project

  initial_node_count = 1

  network    = "default"
  subnetwork = "default"

  # can enable manually as well
  # depends_on = [
  #   google_project_service.container_api
  # ]
}
