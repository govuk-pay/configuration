resource "github_repository" "repo" {
  name                        = var.name
  description                 = var.repository.description
  visibility                  = var.repository.visibility
  homepage_url                = var.repository.homepage_url
  topics                      = var.repository.topics
  has_discussions             = var.repository.has_discussions
  has_issues                  = var.repository.has_issues
  has_projects                = false
  has_wiki                    = false
  allow_merge_commit          = true
  allow_squash_merge          = true
  allow_rebase_merge          = true
  allow_auto_merge            = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  web_commit_signoff_required = false
  archive_on_destroy          = true
}

resource "github_actions_repository_permissions" "actions_permissions" {
  repository           = github_repository.repo.name
  enabled              = var.repository.actions_enabled
  sha_pinning_required = true
  allowed_actions      = "selected"
  allowed_actions_config {
    github_owned_allowed = true
    patterns_allowed     = var.repository.actions_allowed
  }
}

resource "github_branch_default" "default_branch" {
  repository = github_repository.repo.name
  branch     = var.repository.default_branch
}

resource "github_branch_protection" "branch_protection" {
  repository_id  = github_repository.repo.id
  pattern        = var.repository.default_branch
  enforce_admins = true
  required_pull_request_reviews {
    required_approving_review_count = 1
    require_last_push_approval      = true
    dismiss_stale_reviews           = true
  }
}

resource "github_repository_collaborators" "collaborators" {
  repository = github_repository.repo.name

  team {
    team_id    = "team-payments"
    permission = "push"
  }

  team {
    team_id    = "team-payments-admin"
    permission = "admin"
  }

  team {
    team_id    = "team-payments-readonly"
    permission = "pull"
  }
}

resource "github_repository_dependabot_security_updates" "security_updates" {
  repository = github_repository.repo.name
  enabled    = true
}

resource "github_repository_vulnerability_alerts" "vulnerability_alerts" {
  repository = github_repository.repo.name
  enabled    = true
}

resource "github_workflow_repository_permissions" "test" {
  repository                   = github_repository.repo.name
  default_workflow_permissions = "read"
}
