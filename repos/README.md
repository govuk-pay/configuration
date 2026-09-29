# Repository Management

## Adding or modifying repository configuration

If creating a new repository, first consult the
[new repository checklist](https://manual.payments.service.gov.uk/manual/development-processes/new-repository-checklist.html).

Repositories are specified by populating the Terraform variable definition file
`repos.auto.tfvars.json`. This is automatically picked up by Terraform during
its operation (through the `.auto.` infix). Within this we specify the `repos`
as a map of objects, where the key is a repository name and the value is the set
of attributes to configure the repository. Documentation on each possible
attribute can be found within the
[repository module](../modules/repository/README.md)

## Enforce passing CI checks before merge

If you add a new CI job to a repository that must succeed prior to any PRs being
merged, you can set the `required_status_checks` attribute on the repository in
question, for example:

``` json
    "pay-cli": {
      "visibility": "private",
      "description": "GOV.UK Pay Command Line Interface",
      "required_status_checks": [
        "check_merge / check_merge",
        "detect-secrets",
        "lint",
        "unit-tests"
      ]
    },
```

This must be the name of the check as it appears within the GitHub UI in the
`Checks` tab - you may need to expand each workflow to find the name for the job
you wish to add.
