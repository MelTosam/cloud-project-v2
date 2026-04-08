variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "my_ip" {
  description = "Your public IP with /32 for SSH access"
  type        = string
}