variable "allowed_ip_ranges" {
  description = "List of IP ranges to be allowed via WAF"
  type        = list(string)
}

variable "cache_redis_address" {
  description = "Elasticache Redis cluster address"
  type        = string
}

variable "cache_redis_port" {
  type = string
}

variable "cache_redis_sg_id" {
  description = "Elasticache Redis security group ID"
  type        = string
}

variable "cpu" {
  default = 2048
  type    = number
}

variable "db_identifier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_postgres_address" {
  type = string
}

variable "db_postgres_port" {
  type = string
}

variable "db_postgres_sg_id" {
  description = "Postgres DB security group ID"
  type        = string
}

variable "desired_count" {
  description = "Number of instances of the task definition."
  default     = 1
  type        = number
}

variable "ecs_alb_arn" {
  description = "ECS Application Loadbalancer ARN"
  type        = string
}

variable "ecs_alb_sg_id" {
  description = "Application load-balancer security group ID"
  type        = string
}

variable "ecs_service_base_sg_id" {
  description = "Security group ID of Flask Healtcheck ECS Service"
  type        = string
}

variable "environment" {
  description = "The environment we are provisioning, i.e. test, do not mistake this with the AWS account"
  type        = string
}

variable "fqdn_application" {
  description = "Application fully qualified domain name"
  type        = string
}

variable "hosted_zone_public_id" {
  description = "Public Hosted Zone ID"
  type        = string
}

variable "memory" {
  type = number
}

variable "port_http" {
  description = "HTTP port"
  type        = number
}

variable "port_https" {
  description = "HTTPs port"
  type        = number
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "private_subnets_cidr_blocks" {
  description = "The list of private subnet CIDR blocks"
  type        = list(string)
}

variable "product_resource_name" {
  description = "Product name to be used in the name of different components"
  type        = string
}

variable "product_subdomain" {
  description = "Sub domain name associated with the product"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "public_subnets_cidr_blocks" {
  description = "The list of public subnet CIDR blocks"
  type        = list(string)
}

variable "role_ecs_deployer_step_function_arn" {
  description = "Deployer step function IAM role ARN"
  type        = string
}

variable "role_ecs_deployer_step_function_name" {
  description = "Deployer step function IAM role name"
  type        = string
}

variable "role_ecs_task_arn" {
  description = "Task IAM role ARN"
  type        = string
}

variable "role_ecs_task_exec_arn" {
  description = "Task execution IAM role ARN"
  type        = string
}

variable "role_ecs_task_exec_name" {
  description = "Task execution IAM role name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
}

variable "version_app" {
  description = "Version tag associated with the application's image in ECR"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpce_ecr_api_sg_id" {
  description = "Security group ID of the ECR API VPC endpoint"
  type        = string
}

variable "vpce_ecr_dkr_sg_id" {
  description = "Security group ID of ECR Docker VPC endpoint"
  type        = string
}

variable "vpce_logs_sg_id" {
  description = "Security group ID of Logs VPC endpoint"
  type        = string
}

variable "vpce_s3_prefix_list_id" {
  description = "Prefix list ids or S3 VPC endpoint"
  type        = string
}

variable "vpce_s3_sg_id" {
  description = "Security group ID of the S3 VPC endpoint"
  type        = string
}

variable "vpce_secretsmanager_sg_id" {
  description = "Security group ID of the Secrets Manager VPC endpoint"
  type        = string
}
