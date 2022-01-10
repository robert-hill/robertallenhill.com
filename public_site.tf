locals {
  domain = "robertallenhill.com"
  depends_on = [aws_route53_zone.personal_staging]
}

module "acm_request_certificate" {
  source = "cloudposse/acm-request-certificate/aws"
  providers = {
    aws = aws.east
  }

  version                     = "0.16.0"
  domain_name                 = local.domain
  wait_for_certificate_issued = true
}

data "aws_route53_zone" "zone" {
  name = local.domain
  depends_on = [aws_route53_zone.personal_staging]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.personal.zone_id
  name    = "www.robertallenhill.com"
  type    = "CNAME"
  ttl     = "300"
  records = [module.cloudfront_s3_cdn.cf_domain_name]
}

module "cloudfront_s3_cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.80.0"

  name               = "rhill-vcard-website"
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

  depends_on = [module.acm_request_certificate_staging]
}

output "s3_bucket" {
  description = "Name of the S3 origin bucket"
  value       = module.cloudfront_s3_cdn.s3_bucket
}