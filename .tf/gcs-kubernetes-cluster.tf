# Create a GKE cluster with a preemptible node pool
# This is bare bones stuff, but it's enough for you to get started.
# Note that I create a service account for the nodes, as per Google recommendations.
resource "random_pet" "service_account_prefix" {
  length    = 2
  separator = "-"
}

resource "random_integer" "cluster_id" {
  min = 1
  max = 10000
}


resource "google_service_account" "default" {
  account_id   = random_pet.service_account_prefix.id
  display_name = "Demo Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "${var.repository_name}-cluster-${random_integer.cluster_id.result}"
  location = var.default_region

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.repository_name}-node-pool"
  location   = var.default_region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
