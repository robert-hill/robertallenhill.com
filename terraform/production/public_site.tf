locals {
  domain = "robertallenhill.com"
}

locals {
  www = "www.robertallenhill.com"
}

data "aws_route53_zone" "zone" {
  name = local.domain
}

module "acm_request_certificate" {
  source = "cloudposse/acm-request-certificate/aws"
  providers = {
    aws = aws.east
  }

  version                     = "0.16.0"
  domain_name                 = local.domain
  subject_alternative_names   = [local.www]
  wait_for_certificate_issued = true
}

module "cloudfront_s3_cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.82.4"

  name               = "rhill-vcard-website"
  encryption_enabled = true

  # DNS Settings
  parent_zone_id      = data.aws_route53_zone.zone.id
  acm_certificate_arn = module.acm_request_certificate.arn
  aliases             = [local.domain, local.www]
  ipv6_enabled        = true

  # Caching Settings
  default_ttl = 300
  compress    = true

  # WAF
  web_acl_id = aws_wafv2_web_acl.robertallenhill_com.arn

  # Website settings
  website_enabled         = true
  dns_alias_enabled       = true
  versioning_enabled      = true
  allow_ssl_requests_only = false
  index_document          = "index.html" # absolute path in the S3 bucket
  error_document          = "404.html"   # absolute path in the S3 bucket
}

resource "aws_wafv2_web_acl" "robertallenhill_com" {
  provider = aws.east
  name     = "robertallenhill-com-waf"
  scope    = "CLOUDFRONT"
  default_action {
    allow {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "robertallenhill-com-waf"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = 0

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAdminProtectionRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 1

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesAnonymousIpList"
    priority = 2

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 3

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 4

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesPHPRuleSet"
    priority = 5

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesPHPRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 6

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesWordPressRuleSet"
    priority = 9

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesWordPressRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesWordPressRuleSet"
      sampled_requests_enabled   = true
    }
  }

}

output "s3_bucket" {
  description = "Name of the S3 origin bucket"
  value       = module.cloudfront_s3_cdn.s3_bucket
}