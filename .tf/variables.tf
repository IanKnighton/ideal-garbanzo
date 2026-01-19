variable "default_region" {
  description = "The default region for cloud resources"
  type        = string
  default     = "us-west3" # Replace with your preferred GCP region
}

# In private repos, you can hardcode this. 
# In public repos, use GitHub Actions secrets to set this value.
variable "default_project" {
  description = "The default GCP project ID"
  type        = string
}

variable "repository_owner" {
  description = "The owner of the GitHub repository"
  type        = string
  default     = "IanKnighton" # Replace with your GitHub username
}

variable "repository_name" {
  description = "The name of the GitHub repository"
  type        = string
  default     = "ideal-garbanzo" # Replace with your GitHub repository name
}

variable "container_image" {
  description = "The container image to deploy"
  type        = string
  default     = "us-docker.pkg.dev/jump-test-ik/ideal-garbanzo/app:20260119.3" # Replace with your desired container image
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = "ideal-garbanzo-instance" # Replace with your desired instance name
}
