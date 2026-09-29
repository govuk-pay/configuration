variable "name" {
  type        = string
  description = "The name of the repository"
}

variable "repository" {
  type = object({
    visibility             = string
    description            = optional(string, null)
    homepage_url           = optional(string, null)
    default_branch         = optional(string, "main")
    has_discussions        = optional(bool, false)
    has_issues             = optional(bool, true)
    license_template       = optional(string, null)
    topics                 = optional(list(string), [])
    actions_enabled        = optional(bool, true)
    actions_allowed        = optional(list(string), [])
    allow_push_to_main     = optional(bool, false)
    fast_forward_only      = optional(bool, false)
    required_status_checks = optional(list(string), [])
    push_teams             = optional(list(string), ["team-payments"])
    admin_teams            = optional(list(string), ["team-payments-admin"])
    pull_teams             = optional(list(string), ["team-payments-readonly"])
  })
  description = <<-EOF
  visibility: (Required) Whether the project is `public`, `private`, or `internal`.
  description: (Optional) A description of the repository.
  homepage_url: (Optional) URL of a page describing the project.
  default_branch: (Optional) The name of the default branch of the repository. Defaults to `main`.
  has_discussions: (Optional) Whether to enable GitHub discussions. Defaults to `false`.
  has_issues: (Optional) Whether to enable GitHub issues. Defaults to `true`.
  license_template: (Optional) Specify a licence templace to use, e.g. `mit`.
  topics: (Optional) Specify topics associated with the repository.
  actions_enabled: (Optional) Whether GitHub actions are enabled. Defaults to `true`.
  actions_allowed: (Optional) An additive list of external GitHub actions to allow. GitHub and enterprise owned actions are enabled by default. We also enable ruby actions by default.
  allow_push_to_main: (Optional) Whether direct pushing to main is allowed. Defaults to `false`.
  fast_forward_only: Require branches to be up to date before they can be merged. Defaults to `false`.
  required_status_checks: A list of job names or IDs that must pass prior to merging. Defaults to `[]`.
  push_teams: (Optional) The list of GitHub teams which have push access. Defaults to `["team-payments"]`.
  admin_teams: (Optional) The list of GitHub teams which have admin access. Defaults to `["team-payments-admin"]`.
  pull_teams: (Optional) The list of GitHub teams which have pull access. Defaults to `["team-payments-readonly"]`.
  EOF
}
