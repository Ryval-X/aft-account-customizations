provider "aws" {
  region = var.aws_region
}

# Example: Tag the AWS account
resource "aws_organizations_account" "this" {
  account_id = var.account_id

  tags = {
    Environment = "dev"
    Owner       = var.owner
    Project     = var.project
  }
}

# Example: Create a custom IAM role for developers
resource "aws_iam_role" "dev_role" {
  name = "DevCustomRole"

  assume_role_policy = data.aws_iam_policy_document.dev_assume_role_policy.json

  tags = {
    Environment = "dev"
    Owner       = var.owner
  }
}

data "aws_iam_policy_document" "dev_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.developer_principal_arn]
    }
  }
}

# Example: Attach a managed policy to the custom role
resource "aws_iam_role_policy_attachment" "dev_attach_policy" {
  role       = aws_iam_role.dev_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
