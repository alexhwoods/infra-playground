# resource "google_project_service" "container_api" {
#   project = var.project
#   service = "container.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }
# }
