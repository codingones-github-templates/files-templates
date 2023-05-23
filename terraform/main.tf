#<!-- VARIABLES
#__TERRAFORM_ORGANIZATION
#__TERRAFORM_WORKSPACE
#__AWS_PROVIDER_REGION
#-->
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "__TERRAFORM_ORGANIZATION"

    workspaces {
      name = "__TERRAFORM_WORKSPACE"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

provider "aws" {
  region = "__AWS_PROVIDER_REGION"
}

provider "tfe" {
  token = var.tfe_token
}
