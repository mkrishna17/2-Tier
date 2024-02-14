data "aws_acm_certificate" "issued" {
  domain   = var.Certificate_Domain_Name
  statuses = ["ISSUED"]
}

#creating Cloud Formation distribution
resource "aws_cloudfront_distribution" "my_distribution" {
    enabled = true
    aliases = [var.Additional_Domain_Name] 
    origin {
      domain_name = var.Additional_Domain_Name
      origin_id   = var.ALB_Domain_Name
      custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = [ "TLSv1.2" ]
      }
    }

    # AWS Managed Caching Policy (CachingDisabled)
    default_cache_behavior {
      # Using the CachingDisabled managed policy ID:
      allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
      cached_methods = ["GET", "HEAD", "OPTIONS"]
      target_origin_id = var.ALB_Domain_Name
      viewer_protocol_policy = "redirect-to-https"
      forwarded_values {
        
        headers = []
        query_string = true
        cookies {
          forward = "all"
        }
      }
    }

    restrictions {
      geo_restriction {
        restriction_type = "whitelist"
        locations        = ["US", "CA", "IN"]
      }
    }
      tags = {
        Name = var.project_name
      }
    viewer_certificate {
      acm_certificate_arn = data.aws_acm_certificate.issued.arn
      ssl_support_method = "sni-only"
      minimum_protocol_version = "TLSv1.2_2018"
    }
  }