locals {
  name_prefix     = "${var.environment}-${var.product_resource_name}"
  sub_domain_name = var.environment == "prod" ? "www" : var.environment
}
