output "external_ip" {
  description = "The external IP address of the Kubernetes service"
  value       = kubernetes_service_v1.service.status[0].load_balancer[0].ingress[0].ip
}
