# Cloud DevOps Project

A production-style cloud infrastructure project demonstrating end-to-end DevOps practices.

## Architecture

- **Docker** — Application containerised using Apache HTTP server
- **Amazon ECR** — Private container registry storing Docker images
- **Amazon ECS Fargate** — Serverless container orchestration, no EC2 management
- **Application Load Balancer** — Routes internet traffic to healthy containers
- **Terraform** — All infrastructure defined and managed as code
- **GitHub Actions** — Full CI/CD pipeline, automatic deployment on every push

## How it works

1. Developer pushes code to the main branch
2. GitHub Actions pipeline triggers automatically
3. Docker image is built and pushed to Amazon ECR
4. ECS service is forced to redeploy with the new image
5. Users see the updated application with zero manual intervention

## Infrastructure

All AWS infrastructure is provisioned with Terraform including VPC,
public subnets across two availability zones, internet gateway, route tables,
security groups, Application Load Balancer, target group with health checks,
ECS cluster, Fargate task definition, and IAM execution roles.

## Tech Stack

AWS | Docker | Terraform | GitHub Actions | ECS Fargate | ECR | ALB