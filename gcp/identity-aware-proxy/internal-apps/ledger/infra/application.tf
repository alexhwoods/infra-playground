resource "kubernetes_deployment" "ledger" {
  metadata {
    name = "ledger"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "ledger"
        version = "v1.0.0"
      }
    }

    template {
      metadata {
        labels = {
          app     = "ledger"
          version = "v1.0.0"
        }
      }

      spec {
        container {
          image = "ealen/echo-server"
          name  = "application-container"

          env {
            name  = "COLOR"
            value = "bluelast"
          }

          env {
            name  = "WATER"
            value = "bottle"
          }

          resources {
            limits = {
              cpu    = "100m"
              memory = "50Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
