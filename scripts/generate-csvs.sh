#!/bin/bash
set -eu

CURRENT_DIRECTORY="$(dirname "${BASH_SOURCE[0]}")"
cd ./$CURRENT_DIRECTORY/..

python -m pip install -r ../pay-access-control/scripts/requirements.txt

python ../pay-access-control/scripts/generate_members_csv.py > teams/members.csv
python ../pay-access-control/scripts/generate_admins_csv.py > teams/admins.csv
python ../pay-access-control/scripts/generate_teams_csv.py > teams/teams.csv

skip_headers=1
while IFS=, read -r teamname rest
do
    if ((skip_headers))
    then
        ((skip_headers--))
    else
        python ../pay-access-control/scripts/generate_team_csv.py $teamname > teams/team-members/$teamname.csv
    fi
done < teams/teams.csv
