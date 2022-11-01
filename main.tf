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

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
