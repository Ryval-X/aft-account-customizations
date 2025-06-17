variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "The AWS Account ID for customization"
  type        = string
}

variable "owner" {
  description = "Owner of the account"
  type        = string
  default     = "dev-team"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "project"
}

variable "developer_principal_arn" {
  description = "ARN of the IAM principal allowed to assume the dev role"
  type        = string
}
