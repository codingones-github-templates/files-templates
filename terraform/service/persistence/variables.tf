variable "terraform_organization" {
  type        = string
  description = "The organization name on terraform cloud"
  nullable    = false
}

variable "tfe_token" {
  description = "TFE Team token"
  nullable    = false
  default     = false
  sensitive   = true
}

variable "project" {
  type        = string
  nullable    = false
  description = "The name of the project that hosts the environment"
}

variable "service" {
  type        = string
  nullable    = false
  description = "The name of the service that will be run on the environment"
}

variable "private_subnets_ids" {
  type        = list(string)
  nullable    = false
  description = "The ids of the project vpc private subnets where the db instance is hosted"
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = "The id of the project vpc"
}