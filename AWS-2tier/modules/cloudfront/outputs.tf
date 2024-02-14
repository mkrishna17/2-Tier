output "Cloudfront_Domain_Name" {
    value = aws_cloudfront_distribution.my_distribution.domain_name
}

output "Cloudfront_ID" {
    value = aws_cloudfront_distribution.my_distribution.id
}

output "Cloudfront_ARN" {
  value = aws_cloudfront_distribution.my_distribution.arn
}

output "Cloudfront_Status" {
  value = aws_cloudfront_distribution.my_distribution.status
}

output "Cloudfront_Hosted_Zone_ID" {
  value = aws_cloudfront_distribution.my_distribution.hosted_zone_id
}
