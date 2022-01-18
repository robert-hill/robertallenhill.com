locals {
  domain = "staging.robertallenhill.com"
}

locals {
  zone = "robertallenhill.com"
}

module "acm_request_certificate" {
  source = "cloudposse/acm-request-certificate/aws"
  providers = {
    aws = aws.east
  }

  zone_id                     = data.aws_route53_zone.zone.id
  version                     = "0.16.0"
  domain_name                 = local.domain
  wait_for_certificate_issued = true
}

module "cloudfront_s3_cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.80.0"

  name               = "rhill-website-staging"
  encryption_enabled = true

  # DNS Settings
  parent_zone_id      = data.aws_route53_zone.zone.id
  acm_certificate_arn = module.acm_request_certificate.arn
  aliases             = [local.domain]
  ipv6_enabled        = true

  # Caching Settings
  default_ttl = 300
  compress    = true

  # Website settings
  website_enabled         = true
  dns_alias_enabled       = true
  versioning_enabled      = true
  allow_ssl_requests_only = false
  index_document          = "index.html" # absolute path in the S3 bucket
  error_document          = "index.html" # absolute path in the S3 bucket
}

output "s3_bucket" {
  description = "Name of the S3 origin bucket"
  value       = module.cloudfront_s3_cdn.s3_bucket
}

resource "aws_s3_bucket" "test" {
  name = "rhill-terraform-test"
}