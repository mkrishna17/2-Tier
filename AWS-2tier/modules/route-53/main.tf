data "aws_route53_zone" "public-zone" {
  name         = var.Hosted_Zone_Name
  private_zone = false
}

resource "aws_route53_record" "Cloudfront_record" {
  zone_id = data.aws_route53_zone.public-zone.zone_id
  name    = "week3.${data.aws_route53_zone.public-zone.name}"
  type    = "A"
  
  alias {
    name                   = var.Cloudfront_Domain_Name
    zone_id                = var.Cloudfront_Hosted_Zone_ID
    evaluate_target_health = false
  }
}
       