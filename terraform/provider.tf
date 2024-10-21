
provider "aws" {
  region = var.region # Replace with your preferred region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.10.0"
    }
  }
}