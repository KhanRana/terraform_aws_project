terraform {
  required_providers {
    aws = {
        source = "hashcorp/aws"
        version = "~> 5.0"
    }
  }
}

# configure provider as aws

provider "aws" {
  region = "eu-west-2"
}
