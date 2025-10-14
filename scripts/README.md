# scripts/watch_all_repos.sh
## Description
Script to set all repos in an organisation to be watched by a user. 
Managed by dev-platform

Security Managers only get Security Alerts for repositories they are watching. There are over 200 repositories and the vast majority are not watched. This script is intended to be ran by a Security Manager so that they receive alerts for all repositories.

<br />

## Pre-requisites
**The command-line JSON processor `jq` package installed**

`brew install jq` - see https://formulae.brew.sh/formula/jq

<br />

**A Personal Access Token**

This can be created in Github - https://github.com/settings/tokens

Click the `Generate new token` button

Choose `Generate new token (classic)`

If requested, enter the authentication code from your authentication app

Fill in the `Note` field to say what the token is for eg 'Setting Watched Repos'

Set the `Expiration` days from the drop-dowm. The default is 30 days, but 7 should be sufficient

In `Select scopes` check the top `repo` box. This will auto-check the other values in the `repo` section

Click the `Generate token` button

When you return to the `Personal access tokens (classic)` page the value for the new token will be displayed in a green box

Copy the value for the token. This is the only time the value will be displayed and it is required when running the script below

Note: at time of writing fine-grained personal access tokens are in Beta and don't fetch information about private repositories. Therefore, a classic personal access token must be used

<br />

## How To Run
In the `configuration` repo, go to the `scripts` folder

Run `./watch_all_repos.sh`

When prompted, enter the value of your Personal Access Token created above

The script will fetch all repositories you have access to, loop through them, set the repositipries to be watched by you and check that watching the repository was successful


