#<!-- VARIABLES
#TERRAFORM_ORGANIZATION
#TERRAFORM_WORKSPACE
#AWS_PROVIDER_REGION
#PROJECT
#SERVICE
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
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "AWS_PROVIDER_REGION"
}

variable "project" {
  type        = string
  nullable    = false
  description = "The name of the project that hosts the environment"
  default     = "PROJECT"
}

variable "service" {
  type        = string
  nullable    = false
  description = "The name of the service that will be run on the environment"
  default     = "SERVICE"
}
