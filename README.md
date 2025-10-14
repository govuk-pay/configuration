THIS WILL NEED REWRITING

Some of this may still be Digital Identity specific.

# GitHub Organisation Configuration

[![Teams and Members management](https://github.com/govuk-pay/configuration/actions/workflows/teams_and_members.yaml/badge.svg?branch=main)](https://github.com/govuk-pay/configuration/actions/workflows/teams_and_members.yaml)

## User Management

### Adding members to the organisation

> [!NOTE]
> When a new member is added to they will receive an invitation by e-mail to join the organization. They need to accept the invitation for GitHub to reflect the changes made in our configuration

To be added to the organisation, the user must meet the Security Policy to be added to the organisation. [Access to GitHub](https://team-manual.account.gov.uk/new-starter-guide/github-access-management/)

Organisation member definitions are in [`members.csv` file](./teams/members.csv).

All GitHub users when added to the `govuk-pay` organisation must be added to this file.

Terraform resource used is [`github_membership` resources](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership).

### Adding outside collaborators to repositories

Colleagues without Security Clearance (see [`policy`](https://team-manual.account.gov.uk/new-starter-guide/github-access-management/#for-colleagues-without-security-clearance) in DI Team Manual) can be added directly into the repositories they need to be concerned about, with the right least privilege level of access. The repository must exist prior to adding outside collaborators.

**This does not apply to people joining the programme who just haven't got around to applying for SC yet - they should get that application in place before being given access to any tooling.**

In [`collaborators.csv`](./teams/collaborators.csv) add a line per repository for each GitHub user. Permission levels are: `pull` for read-only access, `push` for write access.

Example:

```csv
username,repository,permission
john-doe,di-team-repo-a,push
john-doe,architecture,pull
```

These users should not be added to members.csv, or any of the team-members/*.csv files.

## Team Management

### Adding Teams

Organisation teams are created by adding the team name and description to [`teams.csv` file](./teams/teams.csv).

Example:

```csv
name,description,privacy
perf-testers,Perf Testing Team,closed
dev-platform,Dev Platform,closed
security-team,Security Team,closed
```

Terraform resources used are [`github_team` resources](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) and [`github_team_membership` resources](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership)

### Adding members to teams

Members are added to teams by creating a csv file in directory [`team-members`](./teams/team-members). The filename must match the team name as set in [`teams.csv` file](./teams/teams.csv).
Add the members GitHub usernames to the file as shown in the example.

Adding members to the `dev-platform` team, create a file in [`team-members`](./teams/team-members) called `dev-platform.csv`.

Example:

```csv
username,role
fpmrqs,member
devdutoitGDS,member
jamesmelville-gds,member
```

The team member must also be added to [`members.csv` file](./teams/members.csv) and this can be performed in the same commit.

### Removing leavers from the program/organisation

If someone who leaves the organisation has any personal access tokens used in GH actions these will need to be changed to
a user who is still in the program. If the leaver is the last person to update the schedule line in a scheduled workflow
this will also stop working when they leave the govuk-pay org. [See these docs for more info.](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#schedule)

## Sort CSV files for everyone's sanity

The `./sort-csvs.sh` command in the `teams/` directory will sort the CSV files above.
This will keep everything nice and sane. Make sure to check it hasn't destroyed anything before you commit! :eyes:

## Applying Terraform

Raise a PR with your team and member changes. [`Pre-merge checks`](.github/workflows/pre-merge-checks.yaml) GitHub action will validate the csv files and run a plan to validate the terraform modules.

When PR is merged, the [`Teams and Members management`](.github/workflows/teams_and_members.yaml) GitHub action will run some validation on the config and then apply on merge.

# Organisation owners only

## Local development

### Requirements

* Terraform - consolidate version with [`versions.tf` file](./teams/versions.tf)
* `GITHUB_TOKEN` - GitHub's Personal Access Token with `admin:org` and `repo` permissions
* `GITHUB_OWNER` - GitHub organisation name, `govuk-pay`
* S3 and dynamodb access to the di-devplatform-build-prod AWS account.

It is also possible to run this locally with a valid GITHUB_TOKEN and access to AWS.

1. Set github environment variables:

    ```sh
    export GITHUB_TOKEN=ghp_abcdef123456token
    export GITHUB_OWNER=govuk-pay
    ```

2. Set AWS credentials:

    ```sh
    gds aws di-devplatform-build-prod -s
    ```

3. Initialise Terraform module:

    ```sh
    terraform init
    ```

4. Plan and apply changes

    ```sh
    terraform apply -target=github_team.all
    terraform apply
    ```
