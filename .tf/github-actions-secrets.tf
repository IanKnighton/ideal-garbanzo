# Creates GitHub Actions secrets for WIF service account
# These are used by GitHub Actions to authenticate to GCP
# Doing it this way makes it easier on destroy or if the WIP changes 
resource "github_actions_secret" "wif_provider" {
  repository      = var.repository_name
  secret_name     = "WIF_PROVIDER"
  plaintext_value = module.google_wif_service_account.wif_provider
}

resource "github_actions_secret" "wif_service_account" {
  repository      = var.repository_name
  secret_name     = "WIF_SERVICE_ACCOUNT"
  plaintext_value = module.google_wif_service_account.wif_service_account
}
