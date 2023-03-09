terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.57.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_iam_user" "mainuser" {
  name = "mainuser"
  path = "/system/"

  tags = {
    tag-key = "mainuser"
  }
}

resource "aws_iam_group" "maingroup" {
  name = "maingroup"
  path = "/users/"
}

resource "aws_iam_user_policy" "mainpolicy" {
  name = "mainuserpolicy"
  user = aws_iam_user.mainuser.name

# Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}