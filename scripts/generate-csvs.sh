#!/bin/bash
set -eu

CURRENT_DIRECTORY="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd $CURRENT_DIRECTORY/..
CSV_OUTPUT_PATH="${CSV_OUTPUT_PATH:-${CURRENT_DIRECTORY}/../teams}"

python -m pip install -r ../pay-access-control/scripts/requirements.txt

python ../pay-access-control/scripts/generate_members_csv.py > "${CSV_OUTPUT_PATH}/members.csv"
python ../pay-access-control/scripts/generate_admins_csv.py > "${CSV_OUTPUT_PATH}/admins.csv"
python ../pay-access-control/scripts/generate_teams_csv.py > "${CSV_OUTPUT_PATH}/teams.csv"

team_members_path="${CSV_OUTPUT_PATH}/team-members"
mkdir -p "${team_members_path}"
skip_headers=1
while IFS=, read -r teamname rest
do
    if ((skip_headers))
    then
        ((skip_headers--))
    else
        python ../pay-access-control/scripts/generate_team_csv.py $teamname > "${team_members_path}/$teamname.csv"
    fi
done < "${CSV_OUTPUT_PATH}/teams.csv"
