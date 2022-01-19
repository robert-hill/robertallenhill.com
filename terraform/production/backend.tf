terraform {
  backend "s3" {
    bucket = "rhill-terraform"
    key    = "personal/terraform.tfstate"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "1.1.3"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform" {
  bucket        = "rhill-terraform"
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
