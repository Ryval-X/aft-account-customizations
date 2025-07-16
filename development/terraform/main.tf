provider "aws" {
  region = "us-east-1"
}

# Set up budget for development accounts
resource "aws_budgets_budget" "dev_budget" {
  name              = "dev-monthly-budget"
  budget_type       = "COST"
  time_unit         = "MONTHLY"
  time_period_start = "2023-01-01_00:00"
  limit_amount      = "1000"
  limit_unit        = "USD"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["finance@example.com"]
  }
}

# IAM policies for developers
resource "aws_iam_role" "developer_role" {
  name = "DeveloperRole"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
