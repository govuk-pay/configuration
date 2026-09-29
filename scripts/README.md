# Helper scripts

## generate-csvs.sh

Calls Python scripts within
[pay-access-control](https://github.com/govuk-pay/pay-access-control) to
generate the required CSV files which are then passed to Terraform to manage
GitHub users and teams.

### How to run

This script requires the `PyYaml` package to run. This can be installed either
through `pip` or through a package manager.

It also requires the `pay-access-control` repository to be present next to the
top folder of this repo (e.g. if the `configuration` repo is at
`/some/path/configuration` then the `pay-access-control` repo should be at
`/some/path/pay-access-control`).
