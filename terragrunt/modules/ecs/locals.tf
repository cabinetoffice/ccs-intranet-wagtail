locals {
  cluster_name = "${local.name_prefix}-cluster"

  family_app           = "application"
  family_leader        = "application-leader"
  app_image            = "${aws_ecr_repository.ccs_intranet.repository_url}:latest"
  app_lb_listener_port = var.port_https
  app_listening_port   = 8080
  app_service_name     = var.product_resource_name
  https_fqdn           = "https://${var.fqdn_application}"

  admin_password                       = "${aws_secretsmanager_secret.app_credentials.arn}:ADMIN_PASSWORD::"
  admin_username                       = "${aws_secretsmanager_secret.app_credentials.arn}:ADMIN_USERNAME::"
  db_password_location                 = "${data.aws_secretsmanager_secret.db_secret.arn}:password::"
  db_username_location                 = "${data.aws_secretsmanager_secret.db_secret.arn}:username::"
  django_secret_key                    = "${aws_secretsmanager_secret.app_credentials.arn}:DJANGO_SECRET::"
  govuk_notify_api_key                 = "${data.aws_secretsmanager_secret.govuk_notify_credentials.arn}:GOVUK_NOTIFY_API_KEY::"
  govuk_notify_plain_email_template_id = "${data.aws_secretsmanager_secret.govuk_notify_credentials.arn}:GOVUK_NOTIFY_PLAIN_EMAIL_TEMPLATE_ID::"

  leader_load_data_seed = 0 # var.environment == "test" ? 1 : 0 # This flag instruct the leader node whether to seed the database or not

  ecr_location = "${data.aws_caller_identity.current.id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"

  name_prefix = "${var.environment}-${var.product_resource_name}"

  s3_upload_name = "uploads-${var.environment}-${var.product_resource_name}-${data.aws_caller_identity.current.account_id}"
}
