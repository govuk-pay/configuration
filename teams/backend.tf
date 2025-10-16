terraform {
  required_version = ">=1.9.6, <2.0.0"

  backend "s3" {
    bucket         = "pay-govuk-terraform-state-deploy"
    key            = "github-configuration.tfstate"
    region         = "eu-west-1"
    acl            = "bucket-owner-read"
    dynamodb_table = "terraform_locks"
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~>6.6.0"
    }
  }
}

provider "github" {
}
