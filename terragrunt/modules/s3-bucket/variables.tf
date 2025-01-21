variable "allowed_ip_ranges" {
  description = "List of IP ranges to be allowed via WAF"
  type        = list(string)
  default     = []
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment in which to deploy (e.g. prod)"
  type        = string
}

variable "read_roles" {
  description = "A list of ARNs to allow actions for reading files"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
}

variable "write_roles" {
  description = "A list of ARNs to allow actions for writing files"
  type        = list(string)
  default     = []
}
