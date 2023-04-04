terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

#If you don't have a vault, you can use the plain text also. In this case i have used vault to inject the RDS master password. 
provider "vault" {
  address = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
  token   = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
}