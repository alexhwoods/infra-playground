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

resource "kubernetes_service" "ledger" {
  metadata {
    name = "ledger"
  }
  spec {
    selector = {
      app     = kubernetes_deployment.ledger.spec[0].template[0].metadata[0].labels.app
      version = kubernetes_deployment.ledger.spec[0].template[0].metadata[0].labels.version
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_ingress" "ledger" {
  metadata {
    name = "ledger"
  }

  spec {
    backend {
      service_name = kubernetes_service.ledger.metadata[0].name
      service_port = kubernetes_service.ledger.spec[0].port[0].target_port
    }

    rule {
      host = "internal.atomiccommits.io"
      http {
        path {
          backend {
            service_name = kubernetes_service.ledger.metadata[0].name
            service_port = kubernetes_service.ledger.spec[0].port[0].target_port
          }

          path = "/*"
        }
      }
    }
  }
}
