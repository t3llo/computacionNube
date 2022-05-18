terraform {
  required_providers {
      aws = {
          source = "hashicopr/aws"
          version = "4.14.0"
      }
  }
}

provider "aws" {}