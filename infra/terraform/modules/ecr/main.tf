locals {

  timeouts = var.timeouts_delete == null && length(var.timeouts) == 0 ? [] : [
    {
      delete = lookup(var.timeouts, "delete", null) == null ? var.timeouts_delete : lookup(var.timeouts, "delete")
    }
  ]
}
resource "aws_ecr_repository" "ecr" {
  name                 = var.naming.ecr_repository
  image_tag_mutability = var.image_tag_mutability
 

  dynamic "timeouts" {
    for_each = local.timeouts
    content {
      delete = lookup(timeouts.value, "delete")
    }
  }


  tags = var.naming.tags

}


resource "aws_ecr_repository_policy" "policy" {
  count      = var.policy == null ? 0 : 1
  repository = aws_ecr_repository.ecr.name
  policy     = var.policy
}


resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  count      = var.lifecycle_policy == null ? 0 : 1
  repository = aws_ecr_repository.ecr.name
  policy     = var.lifecycle_policy
}

