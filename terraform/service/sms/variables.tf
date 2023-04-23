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

variable "domain_name" {
  type        = string
  nullable    = false
  description = "The project registered domain name that cloudfront can use as aliases, for now only one domain is supported"
  default     = ""
}

variable "sender_id" {
  type        = string
  nullable    = true
  description = "Your sender ID can contain up to 11 alphanumeric or hyphen (-) characters. It has to contain at least one letter, and it can't consist only of numbers. It has to start and end with with an alphanumeric character. Some countries and regions may have additional restrictions."
  default     = true
}