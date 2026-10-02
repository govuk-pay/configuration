# Create local values to retrieve items from CSVs
locals {
  csv_path    = coalesce(var.csv_path, path.root)
  members_csv = csvdecode(file("${local.csv_path}/members.csv"))
  admins_csv  = csvdecode(file("${local.csv_path}/admins.csv"))
  members = merge(
    { for member in local.members_csv : member.username => { username = member.username, role = "member" } },
    { for member in local.admins_csv : member.username => { username = member.username, role = "admin" } },
  )
  # Parse team member files
  team_members_path = "${local.csv_path}/team-members"
  team_members_files = {
    for file in fileset(local.team_members_path, "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("${local.team_members_path}/${file}"))
  }
  extra_members = {
    "team-payments" = [
      {
        "role"     = "member"
        "username" = "alphagov-pay-ci-concourse"
      }
    ]
  }
  # Create object for each team-user relationship
  team_members = flatten([
    for team, members in local.team_members_files : [
      for tn, t in github_team.all : {
        slug = t.slug
        members = concat(
          members,
          try(local.extra_members[t.slug], [])
        )
      } if t.slug == team
    ]
  ])
}
