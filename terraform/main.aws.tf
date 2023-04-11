#<!-- VARIABLES
#TERRAFORM_ORGANIZATION
#TERRAFORM_WORKSPACE
#AWS_PROVIDER_REGION
#-->
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "TERRAFORM_ORGANIZATION"

    workspaces {
      name = "TERRAFORM_WORKSPACE"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "AWS_PROVIDER_REGION"
}