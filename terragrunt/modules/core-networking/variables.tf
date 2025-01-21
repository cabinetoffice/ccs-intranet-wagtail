variable "allowed_ip_ranges" {
  description = "List of IP ranges to be allowed via WAF"
  type        = list(string)
}

variable "environment" {
  description = "The environment we are provisioning, i.e. test, do not mistake this with the AWS account"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}
