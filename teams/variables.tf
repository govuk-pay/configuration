variable "github_app_id" {
  type        = string
  description = "GitHub App ID for pay-org-management"
}

variable "github_app_installation_id" {
  type        = string
  description = "Installation ID of the App on govuk-pay org"
}

variable "github_app_pem" {
  type        = string
  description = "PEM-encoded private key for the App"
  sensitive   = true
}
