terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
   backend "s3" {
    bucket         = "terraform-state-sensors-lambda"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {}