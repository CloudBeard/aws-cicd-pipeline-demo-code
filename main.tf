terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      # tflint-ignore: terraform_required_providers
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "apply-s3-mario"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "b_sse" {
  bucket = aws_s3_bucket.b.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
