resource "aws_route53_zone" "personal" {
  name = "robertallenhill.com"
}

resource "aws_route53_record" "mail1-record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "robertallenhill.com"
  type    = "MX"
  ttl     = "300"
  records = [
    "10 mx1.improvmx.com.",
    "20 mx2.improvmx.com."
  ]
}