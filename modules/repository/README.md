# Repository Module

This module utilises the
[github provider](https://registry.terraform.io/providers/integrations/github/latest/docs)
to create a repository and configure its various settings.

## Resources

* [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions)
* [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default)
* [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection)
* [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository)
* [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators)
* [github_repository_dependabot_security_updates.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_dependabot_security_updates)
* [github_repository_vulnerability_alerts.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_vulnerability_alerts)
* [github_workflow_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/workflow_repository_permissions)

## Variables

| Name                                | Description                                                                                                                               | Type           | Default                      | Required |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ---------------------------- | :------: |
| `name`                              | The name of the repository                                                                                                                | `string`       | n/a                          |   yes    |
| `repository`                        | An object with attributes which configure the repository                                                                                  | `object`       | n/a                          |   yes    |
| `repository.visibility`             | Whether the project is `public`, `private`, or `internal`                                                                                 | `string`       | n/a                          |   yes    |
| `repository.description`            | A description of the repository                                                                                                           | `string`       | `null`                       |    no    |
| `repository.homepage_url`           | URL of a page describing the project                                                                                                      | `string`       | `null`                       |    no    |
| `repository.default_branch`         | The name of the default branch of the repository                                                                                          | `string`       | `main`                       |    no    |
| `repository.has_discussions`        | Whether to enable GitHub discussions                                                                                                      | `boolean`      | `false`                      |    no    |
| `repository.has_issues`             | Whether to enable GitHub issues                                                                                                           | `boolean`      | `true`                       |    no    |
| `repository.license_template`       | Specify a licence templace to use, for example `mit`                                                                                      | `string`       | `null`                       |    no    |
| `repository.topics`                 | Specify topics associated with the repository                                                                                             | `list(string)` | `[]`                         |    no    |
| `repository.actions_enabled`        | Whether GitHub actions are enabled                                                                                                        | `boolean`      | `true`                       |    no    |
| `repository.actions_allowed`        | An additive list of external GitHub actions to allow. GitHub and enterprise owned actions are enabled by default, as well as ruby actions | `list(string)` | `[]`                         |    no    |
| `repository.allow_push_to_main`     | Whether direct pushing to main is allowed                                                                                                 | `boolean`      | `false`                      |    no    |
| `repository.fast_forward_only`      | Require branches to be up to date before they can be merged                                                                               | `boolean`      | `false`                      |    no    |
| `repository.required_status_checks` | A list of job names or IDs that must pass prior to merging                                                                                | `list(string)` | `[]`                         |    no    |
| `repository.push_teams`             | The list of GitHub teams which have push access                                                                                           | `list(string)` | `["team-payments"]`          |    no    |
| `repository.admin_teams`            | The list of GitHub teams which have admin access                                                                                          | `list(string)` | `["team-payments-admin"]`    |    no    |
| `repository.pull_teams`             | The list of GitHub teams which have pull access                                                                                           | `list(string)` | `["team-payments-readonly"]` |    no    |
