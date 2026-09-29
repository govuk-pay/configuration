# GOV.UK Pay GitHub Organisation Configuration

This repository uses [pay-access-control][1] as its source of truth for user and team management. Specifically, the [generate-csvs.sh script](https://github.com/govuk-pay/configuration/blob/main/scripts/generate-csvs.sh) will call Python scripts within [pay-access-control][1] to generate csv files to pass to Terraform to manage GitHub.

This repository has been created to be automated by our existing access control and JML processes, as such no actual data about users is stored here. It is important to ensure [pay-access-control][1] is kept up to date and accurate to maintain proper access to GitHub.

## User Management

> [!NOTE]
> When a new member is added to they will receive an invitation by e-mail to join the organization. They need to accept the invitation for GitHub to reflect the changes made in our configuration

GitHub users and their permissions are pulled from the [pay-access-control][1] repository. This is aligned with GOV.UK Pay's access control policy to manage permissions for team members.

In order to add a new team member to GitHub, ensure that they have a `github-user` key in their entry in [`users.yml`](https://github.com/govuk-pay/pay-access-control/blob/main/config/users.yml). Additionally they should be in a [user role](https://github.com/govuk-pay/pay-access-control/tree/main/config/user-roles) specific to their role. For new starters, either new-tech or team-member depending on if they are a technologist or not.

As part of the offboarding process, when someone is removed from [pay-access-control][1], they will automatically be removed from this organisation.

## Team Management

Teams are automatically populated from the source of truth in [pay-access-control][1]. As teams are defined in the services config in that repository, they will be populated here.

Additional teams may be defined for bots and other uses, these can be defined manually in Terraform unless there is a compelling reason to change this.

## Repository Management

Repositories are managed from the `repos/` Terraform root. The source of truth
for the configuration is `repos/repos.auto.tfvars.json`. Further documentation
on repository management is contained within the
[repos README](repos/README.md).

## Applying Terraform

This is automated through Concourse. We have two pipelines:

* [github-user-management](https://pay-cd.deploy.payments.service.gov.uk/teams/pay-deploy/pipelines/github-user-management)

  This is the pipeline for user and team management. Any push to this repository
  or [pay-access-control][1] will result in the Terraform being automatically
  applied. Pull requests against this repository which change paths in the
  `teams/` subdirectory will also trigger a job which will report the output of
  a `terraform plan`.

* [github-repo-management](https://pay-cd.deploy.payments.service.gov.uk/teams/pay-deploy/pipelines/github-repo-management)

  This is the pipeline for repository management. Any push to this repository will
  result in the Terraform being automatically applied. Pull requests against this
  repository which change paths in either the `repos/` or `modules/repository/`
  subdirectory will also trigger a job which will report the output of a
  `terraform plan`.

[1]: https://github.com/govuk-pay/pay-access-control
