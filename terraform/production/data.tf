data "aws_s3_bucket" "terraform" {
  bucket = "rhill-terraform"
}

data "aws_route53_zone" "zone" {
  name = local.domain
}
