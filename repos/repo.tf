module "repository" {
  source     = "../modules/repository"
  for_each   = var.repos
  name       = each.key
  repository = each.value
}

variable "repos" {
  type        = any
  description = <<-EOF
  A map of objects, where the key is the name of a repository and its object
contains the attributes to configure the repository.

  Each attribute and its documentation can be found in the `repository` module
(see ../modules/repository/variables.tf).
  EOF
}
