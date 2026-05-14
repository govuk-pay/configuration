resource "github_membership" "all" {
  for_each = local.members

  username = each.value.username
  role     = each.value.role

  lifecycle {
    ignore_changes = [ role ]
  }
}

