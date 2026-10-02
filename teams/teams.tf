resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("${local.csv_path}/teams.csv")) :
    team.name => team
  }

  name        = each.value.name
  description = each.value.description
  privacy     = each.value.privacy
}

resource "github_team_members" "members" {
  for_each = {
    for tm in local.team_members : tm.slug => tm.members if length(tm.members) > 0
  }

  team_slug = each.key

  dynamic "members" {
    for_each = each.value
    content {
      username = members.value.username
      role     = members.value.role
    }
  }
}
