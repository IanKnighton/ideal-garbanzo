# Uses a module to create a Google Cloud Service Account for Workload Identity Federation
# This is an easy way to do it and it's something I worked on at a previous job
# As long as you've spelled everything correctly, this should "just work"
module "google_wif_service_account" {
  source  = "deseretdigital/ddm-wip-service-account/google"
  version = "4.0.0"

  # THIS IS INCREDIBLY OVER SCOPED AND YOU SHOULD TIGHTEN IT UP FOR PRODUCTION USE
  iam_role_ids     = ["roles/storage.admin", "roles/container.admin", "roles/iam.serviceAccountTokenCreator"]
  project          = var.default_project
  repository_name  = var.repository_name
  repository_owner = var.repository_owner
}
