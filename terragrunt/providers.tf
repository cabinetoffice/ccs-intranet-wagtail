terraform {
  required_version = "= 1.7.0"
  required_providers {
    aws = {
      version = "~> 5.35.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
