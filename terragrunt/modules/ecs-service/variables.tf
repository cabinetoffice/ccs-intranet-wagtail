variable "add_security_group_roles" {
  default     = true
  description = "Whether attache SG rules to enable communication between the LB and ECS service. "
  type        = bool
}

variable "certificate_arn" {
  description = "ARN of the default SSL server certificate"
  type        = string
}

variable "cluster_id" {
  description = "Cluster ID of which the service will be part of"
  type        = string
}

variable "container_definitions" {
  description = "A list of valid container definitions provided as a single valid JSON document"
}

variable "container_port" {
  description = "ort on the container to associate with the load balancer"
  type        = number
}

variable "cpu" {
  description = "Number of cpu units used by the task"
  type        = number
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

variable "family" {
  description = "A unique name for the task definition"
  type        = string
}

variable "listening_port" {
  description = "Port on which the load balancer is listening"
  type        = number
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the tas"
  type        = number
}

variable "name" {
  description = "The service name"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "role_ecs_task_arn" {
  description = "Task IAM role ARN"
  type        = string
}

variable "role_ecs_task_exec_arn" {
  description = "Task execution IAM role ARN"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
}

variable "target_group_arn" {
  description = "ARN of the Load Balancer target group to associate with the service"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
