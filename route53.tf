resource "aws_route53_zone" "personal" {
  name = "robertallenhill.com"
}

resource "aws_route53_zone" "personal_staging" {
  name = "staging.robertallenhill.com"
}