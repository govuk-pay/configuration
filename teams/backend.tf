terraform {
  required_version = ">=1.9.6, <2.0.0"

  backend "s3" {
    bucket       = "pay-govuk-terraform-state-deploy"
    key          = "deploy_github-configuration.tfstate"
    region       = "eu-west-1"
    acl          = "bucket-owner-read"
    use_lockfile = true
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~>6.13.0"
    }
  }
}

provider "github" {
  app_auth {}
}

