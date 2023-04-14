variable "project" {
  type        = string
  nullable    = false
  description = "The name of the project that hosts the environment"
  default     = "PROJECT"
}
#variable "service" {
#  type        = string
#  nullable    = false
#  description = "The name of the service that will be run on the environment"
#  default     = "SERVICE"
#}

variable "domain_name" {
  type        = string
  nullable    = false
  description = "The project registered domain name"
}