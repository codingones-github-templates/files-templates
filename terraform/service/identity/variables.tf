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

variable "user_groups" {
  description = "Map of user groups"
  type = map(object({
    name        = string
    description = string
  }))
  nullable = true
  default = {
    user = {
      name        = "user"
      description = "The default user group for authenticated users"
    }
  }
}

variable "ses_configuration_set_name" {
  type        = string
  nullable    = true
  description = "The ses email configuration set name"
  default     = ""
}

variable "ses_verified_email_identity_source_arn" {
  type        = string
  nullable    = true
  description = "The ses email configuration set name"
  default     = ""
}

variable "sender_id" {
  type        = string
  nullable    = true
  description = "Sender id. Maximum 11 alphanumeric or hyphen (-) characters, including at least one letter and no spaces. It has to start and end with an alphanumeric character. "
  default     = ""
}