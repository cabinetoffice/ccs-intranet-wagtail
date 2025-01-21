variable "environment" {
  description = "The environment we are provisioning, i.e. test, do not mistake this with the AWS account"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
}
