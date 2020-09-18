resource "aws_s3_bucket" "s3" {

  acl           = "private"
  bucket        = var.naming.bucket
  force_destroy = var.force_destroy
  tags          = var.naming.tags
}

