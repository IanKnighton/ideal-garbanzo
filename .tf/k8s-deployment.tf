# Create a Kubernetes deployment
# Another bare bones example, but enough to get you started.
# The GitHub Actions workflow will update the image. 
resource "kubernetes_deployment_v1" "deployment" {
  metadata {
    name = var.instance_name
    labels = {
      app = var.instance_name
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.instance_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.instance_name
        }
      }

      spec {
        container {
          image = var.container_image
          name  = var.instance_name

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/livez"
              port = 80
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }

          readiness_probe {
            http_get {
              path = "/readyz"
              port = 80
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

# Create a LoadBalancer service to expose the deployment
# You can get the external IP with: kubectl get services
resource "kubernetes_service" "service" {
  metadata {
    name = "${var.instance_name}-service"
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
    }
  }

  spec {
    port {
      name     = "${var.instance_name}-service"
      protocol = "TCP"
      port     = 80
    }

    selector = {
      app = var.instance_name
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "deployment_autoscaler" {
  metadata {
    name = "${var.instance_name}-autoscaler"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment_v1.deployment.metadata[0].name
    }

    min_replicas = 2
    max_replicas = 5
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}
