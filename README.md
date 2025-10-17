# GOV.UK Pay GitHub Organisation Configuration

This repository uses [pay-access-control](https://github.com/alphagov/pay-access-control) as its source of truth. Specifically, the [generate-csvs.sh script](https://github.com/govuk-pay/configuration/blob/main/scripts/generate-csvs.sh) will call Python scripts within pay-access-control to generate csv files to pass to Terraform to manage GitHub.

This repository has been created to be automated by our existing access control and JML processes, as such no actual data about users is stored here. It is important to ensure pay-access-control is kept up to date and accurate to maintain proper access to GitHub.

## User Management

> [!NOTE]
> When a new member is added to they will receive an invitation by e-mail to join the organization. They need to accept the invitation for GitHub to reflect the changes made in our configuration

GitHub users and their permissions are pulled from the [pay-access-control](https://github.com/alphagov/pay-access-control) repository. This is aligned with GOV.UK Pay's access control policy to manage permissions for team members.

In order to add a new team member to GitHub, ensure that they have a `github-user` key in their entry in [`users.yml`](https://github.com/alphagov/pay-access-control/blob/main/config/users.yml). Additionally they should be in a (user role)[https://github.com/alphagov/pay-access-control/tree/main/config/user-roles] specific to their role. For new starters, either new-tech or team-member depending on if they are a technologist or not.

As part of the offboarding process, when someone is removed from pay-access-control, they will automatically be removed from this organisation.

## Team Management

Teams are automatically populated from the source of truth in pay-access-control. As teams are defined in the services config in that repository, they will be populated here.

Additional teams may be defined for bots and other uses, these can be defined manually in Terraform unless there is a compelling reason to change this.

## Applying Terraform

> [!NOTE]
> This will be filled out once we have a Concourse pipeline for applying this.
> For now, it is manual while we are prototyping.

# Organisation owners only

## Local development

### Requirements

* `GITHUB_TOKEN` - GitHub's Personal Access Token with `admin:org` and `repo` permissions
* `GITHUB_OWNER` - GitHub organisation name, `govuk-pay`
* S3 and dynamodb access to the govuk-pay-deploy AWS account.

Be extremely careful with GitHub PATs, they have a high level of access, especially as an organisation owner.

1. Set github environment variables:

    ```sh
    export GITHUB_TOKEN=ghp_abcdef123456token
    export GITHUB_OWNER=govuk-pay
    ```

2. Initialise Terraform module:

    ```sh
    aws-vault exec deploy -- terraform init
    ```

4. Plan and apply changes

    ```sh
    aws-vault exec deploy -- terraform apply -target=github_team.all
    aws-vault exec deploy -- terraform apply
    ```
