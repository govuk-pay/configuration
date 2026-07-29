module "repository" {
  source     = "../modules/repository"
  for_each   = var.repos
  name       = each.key
  repository = each.value
}

variable "repos" {
  type = map(any)
}
