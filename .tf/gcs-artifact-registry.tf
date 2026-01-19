# Create a Google Artifact Registry repository
# I create these in the "us" multi-region out of habit. 
# Makes life easier if you are in a DR situation.
resource "google_artifact_registry_repository" "my-repo" {
  location      = "us"
  repository_id = var.repository_name
  format        = "DOCKER"
}
