module "personal-website" {
  source  = "cloudmaniac/static-website/aws"
  version = "1.0.1"
  website-domain-main = "robertallenhill.com"
  website-domain-redirect = "www.robertallenhill.com"
}