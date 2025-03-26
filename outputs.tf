output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_alb.main.dns_name
}

output "rds_endpoint" {
  description = "Endpoint for the RDS instance"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}
