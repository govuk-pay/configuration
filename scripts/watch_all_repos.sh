#! /bin/bash

set -eu

#pre-requisites
#jq package (brew install jq)

read -p 'Enter Github PAT: ' GITHUB_TOKEN
GITHUB_OWNER=${GITHUB_OWNER:-govuk-pay}
GITHUB_API_VERSION=${GITHUB_API_VERSION:-2022-11-28}
FETCHES_PER_PAGE=${FETCHES_PER_PAGE:-100}

repo_urls_arr=('')
public=0
private=0

echo "Getting number of public repos"
public=$(curl -L -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: $GITHUB_API_VERSION" \
  https://api.github.com/orgs/$GITHUB_OWNER \
  | jq -r '.public_repos')
if [[ $public == "null" ]]
then
   public=0
fi  
echo "There were $public public repositories found"

echo "Getting number of private repos"
private=$(curl -L -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: $GITHUB_API_VERSION" \
  https://api.github.com/orgs/$GITHUB_OWNER \
  | jq -r '.owned_private_repos')
if [[ $private == "null" ]]
then
   private=0
fi
echo "There were $private private repositories found"

total=$(($public+$private))
if [ $total -eq 0 ]; then
  echo "There were $total repositories found"
  exit
fi
echo "There are $total repositories in total"
no_of_pages=$(($total / $FETCHES_PER_PAGE))
no_of_pages=$((no_of_pages+=1))

echo "Retrieving names of all repositories"
for (( page = 1; page <= $no_of_pages; page++ ))
do
  echo "Fetching page $page of $no_of_pages"
  urls=$(curl -L -s \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: $GITHUB_API_VERSION" \
    "https://api.github.com/orgs/$GITHUB_OWNER/repos?per_page=$FETCHES_PER_PAGE&page=$page" \
    | jq -r '.[].html_url') 
    for url in ${urls[@]}
    do
        repo_urls_arr=(${repo_urls_arr[@]} ${url})
        echo $url
    done
done

echo "${#repo_urls_arr[@]} repositories found"

for url in ${repo_urls_arr[@]}
  do
    api_url=${url/github.com/api.github.com/repos}/subscription

    echo "Setting repository $url to be watched"
    watch=$(curl -L -s \
      -X PUT \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -H "X-GitHub-Api-Version: $GITHUB_API_VERSION" \
      $api_url \
      -d '{"subscribed":true,"ignored":false}')

    #check the repo was set to be watched correctly
    watch=$(curl -L -s \
      -X GET \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      -H "X-GitHub-Api-Version: $GITHUB_API_VERSION" \
      $api_url | jq -r '.subscribed')
    if [ "$watch" = "false" ]
    then
      echo "Setting $url to be watched has failed"
    fi
  done 
