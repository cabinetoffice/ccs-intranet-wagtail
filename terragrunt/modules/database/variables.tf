variable "cache_redis_sg_id" {
  description = "Elasticache Redis security group ID"
  type        = string
}

variable "db_postgres_sg_id" {
  description = "Postgres DB security group ID"
  type        = string
}

variable "environment" {
  description = "The environment we are provisioning, i.e. test, do not mistake this with the AWS account"
  type        = string
}

variable "postgres_instance_type" {
  description = "RDS instance type for individual environments"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "product_resource_name" {
  description = "Product name to be used in the name of different components"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
}


variable "version_postgres_engine" {
  description = "DB engine version"
  type        = string
}
