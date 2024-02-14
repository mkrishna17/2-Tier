output "ALB-DNS-NAME" {
  value = aws_lb.alb.dns_name
}

output "ALB-TG-ARN" {
  value = aws_lb_target_group.alb-target-group.arn
}