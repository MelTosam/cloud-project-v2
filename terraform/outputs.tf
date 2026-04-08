output "alb_dns_name" {
  description = "Open this in your browser to see the live app"
  value       = aws_lb.main.dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "ecr_repository_uri" {
  description = "ECR repository URI for CI/CD pipeline"
  value       = "149536456043.dkr.ecr.us-east-1.amazonaws.com/cloud-project"
}