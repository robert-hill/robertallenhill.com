terraform {
  backend "s3" {
    bucket = "rhill-terraform"
    key    = "personal/staging/terraform.tfstate"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "1.1.5"
}

provider "aws" {
  region = "us-west-2"
}
