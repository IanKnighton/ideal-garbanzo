module "kubernetes_workload_identity" {
  source       = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name         = "${var.repository_name}-sa"
  cluster_name = google_container_cluster.primary.name
  project_id   = var.default_project
  roles        = ["roles/secretmanager.secretAccessor"]
}
