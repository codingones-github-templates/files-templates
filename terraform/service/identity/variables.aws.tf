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

variable "user_group_admin" {
  type        = string
  nullable    = false
  description = "The user group admin name"
  default     = "admin"
}
variable "user_group_user" {
  type        = string
  nullable    = false
  description = "The user group user name"
  default     = "user"
}