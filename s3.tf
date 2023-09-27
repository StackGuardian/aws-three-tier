resource "random_pet" "random" {
  length = 2
}

locals {
  bucket_name = "stackguardian-${random_pet.random.id}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = local.bucket_name
  force_destroy = true
  tags = {
    "Name"        = "aws_s3_bucket.s3_bucket.id"
    "Description" = "Demo Bucket for hosting the static website"
    "CreatedBy"   = "StackGuardian"
  }
}
