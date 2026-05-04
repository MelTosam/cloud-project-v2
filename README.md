# End-to-End AWS Cloud Infrastructure & CI/CD Platform

A production-style cloud environment built from scratch on AWS, demonstrating real-world infrastructure engineering across networking, containerisation, infrastructure as code, and automated deployments.

> **Note:** Infrastructure has been torn down to manage costs (`terraform destroy`). All code, configuration, and architecture documentation remain in this repository.

---

## What This Project Does

This project deploys a containerised web application on AWS using a fully automated pipeline. Every push to the `main` branch triggers a GitHub Actions workflow that builds a Docker image, pushes it to Amazon ECR, and deploys it to ECS Fargate — all without manual intervention.

The infrastructure is provisioned entirely through Terraform with reusable modules, IAM least-privilege policies throughout, and multi-AZ availability for resilience.

---

## Architecture Overview

```
GitHub (push to main)
        │
        ▼
GitHub Actions CI/CD Pipeline
        │
        ├── Build Docker image
        ├── Push to Amazon ECR
        └── Deploy to ECS Fargate
                │
                ▼
        Application Load Balancer
                │
        ┌───────┴───────┐
        ▼               ▼
  ECS Fargate       ECS Fargate
  (AZ 1)            (AZ 2)
        │
        ▼
  VPC with public subnets
  across multiple availability zones
```

---

## Tech Stack

| Category | Technology |
|---|---|
| Cloud Provider | AWS |
| Networking | VPC, Public Subnets, Internet Gateway, Route Tables, Security Groups |
| Compute | Amazon ECS (Fargate) |
| Container Registry | Amazon ECR |
| Load Balancing | Application Load Balancer (ALB) |
| Infrastructure as Code | Terraform (modular configuration, remote state) |
| Containerisation | Docker |
| CI/CD | GitHub Actions |
| Monitoring | Amazon CloudWatch |
| IAM | Least-privilege roles and policies |
| Scripting | Python, Bash |

---

## Infrastructure Components

### Networking
- Custom VPC with CIDR block configuration
- Public subnets across two availability zones for high availability
- Internet Gateway and route tables for outbound traffic
- Security groups with least-privilege inbound and outbound rules

### Compute
- ECS Fargate cluster — serverless container execution, no EC2 management
- Task definition with resource allocation and container configuration
- ECS Service managing desired task count and deployment strategy

### Load Balancing
- Application Load Balancer routing HTTP traffic to ECS tasks
- Target group with health check configuration
- Listener rules for traffic distribution

### Container Registry
- Amazon ECR repository storing versioned Docker images
- Image lifecycle policy for cost management

### CI/CD Pipeline
- GitHub Actions workflow triggered on push to `main`
- Automated Docker build and push to ECR
- ECS service update forcing new deployment
- No manual steps required end to end

### Infrastructure as Code
- Terraform modules for reusable, environment-agnostic configuration
- Variables and outputs for clean separation of concerns
- Remote state management
- `terraform destroy` used for cost-conscious resource management between development cycles

---

## Project Structure

```
cloud-project-v2/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD pipeline
├── terraform/
│   ├── main.tf                 # Root module
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Output values
│   └── modules/
│       ├── networking/         # VPC, subnets, IGW, routes
│       ├── security/           # Security groups, IAM roles
│       ├── compute/            # ECS cluster, task definition, service
│       ├── loadbalancer/       # ALB, target group, listener
│       └── ecr/                # Container registry
├── app/
│   └── Dockerfile              # Application container definition
└── README.md
```

---

## Key Engineering Decisions

**Why Fargate over EC2?** Eliminates server management overhead. No patching, no capacity planning, scales automatically with demand.

**Why modular Terraform?** Modules make the infrastructure reusable across environments (dev, staging, prod) with minimal configuration changes.

**Why GitHub Actions?** Native integration with the repository, zero additional tooling, triggered automatically on every push to main.

**Why terraform destroy between cycles?** AWS charges for running resources. Destroying and reapplying infrastructure demonstrates confidence in the IaC approach — if your Terraform is correct, you can rebuild the entire environment in minutes.

---

## How to Deploy

### Prerequisites
- AWS account with appropriate permissions
- Terraform installed (v1.0+)
- Docker installed
- GitHub repository secrets configured:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_REGION`

### Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Deploy Application
Push any change to the `main` branch. GitHub Actions handles the rest automatically.

### Tear Down
```bash
terraform destroy
```

---

## What I Learned

- Designing multi-AZ VPC architectures for production resilience
- Managing IAM permissions with least-privilege principles
- Building end-to-end CI/CD pipelines that deploy on every commit
- Debugging ECS task failures, ALB health check issues, and Terraform state drift
- Cost-conscious infrastructure design — knowing when to destroy and rebuild

---

## Author

**Melvis Bih Tosam**
Cloud and DevOps Engineer
[github.com/MelTosam](https://github.com/MelTosam)

AWS Certified Solutions Architect — Associate
