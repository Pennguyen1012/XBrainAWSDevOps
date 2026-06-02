variable "aws_region" {
  description = "The AWS Region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "The environment variable"
  type        = string
}

variable "project_name" {
  description = "The project name used as prefix for the resources"
  type        = string
  default     = "s3-replication-lab-pnguyen-3110"
}

variable "fake_secret_token" {
  description = "A fake secret for evidence"
  type        = string
  sensitive   = true
  default     = "SuperSecretPassword123!"
}

output "secret_token_output" {
  value     = var.fake_secret_token
  sensitive = true
}
