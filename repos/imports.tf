import {
  for_each = var.repos
  to       = module.repository[each.key].github_repository.this
  id       = each.key
}

import {
  for_each = var.repos
  to       = module.repository[each.key].github_branch_protection.this
  id       = "${each.key}:${lookup(each.value, "default_branch", "main")}"
}
