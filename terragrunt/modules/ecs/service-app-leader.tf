module "ccs_intranet_leader_service" {
  source = "../ecs-service"

  add_security_group_roles = true
  certificate_arn          = aws_acm_certificate.ccs_intranet.arn
  cluster_id               = aws_ecs_cluster.ccs_intranet.id
  container_definitions = templatefile(
    "${path.module}/templates/task-definitions/ccs-intranet.json.tftpl",
    {
      admin_password                       = local.admin_password
      admin_username                       = local.admin_username
      awslogs-group                        = aws_cloudwatch_log_group.ccs_intranet.name
      awslogs-region                       = data.aws_region.current.name
      cache_redis_address                  = var.cache_redis_address
      container_port                       = local.app_listening_port
      cpu                                  = var.cpu
      csrf_trusted_origin                  = local.https_fqdn
      db_name                              = var.db_name
      db_postgres_address                  = var.db_postgres_address
      db_postgres_password                 = local.db_password_location
      db_postgres_port                     = var.db_postgres_port
      db_postgres_username                 = local.db_username_location
      db_sslrootcert_path                  = "/code/postgresql.pem"
      django_secret_key                    = local.django_secret_key
      django_settings_module               = "ccsintranet.settings.production"
      govuk_notify_api_key                 = local.govuk_notify_api_key
      govuk_notify_plain_email_template_id = local.govuk_notify_plain_email_template_id
      image                                = local.app_image
      memory                               = var.memory
      name                                 = "${local.app_service_name}-leader"
      run_migrations                       = 1
      load_data_seed                       = local.leader_load_data_seed
      s3_bucket_upload                     = local.s3_upload_name
      wagtail_base_url                     = local.https_fqdn
    }
  )
  container_port         = local.app_listening_port
  cpu                    = var.cpu
  desired_count          = 1 # Must be one. Since the leader is in charge of migration and to avoid race condition
  ecs_alb_arn            = var.ecs_alb_arn
  ecs_alb_sg_id          = var.ecs_alb_sg_id
  ecs_service_base_sg_id = var.ecs_service_base_sg_id
  family                 = local.family_leader
  listening_port         = local.app_lb_listener_port
  memory                 = var.memory
  name                   = "${local.app_service_name}-leader"
  private_subnet_ids     = var.private_subnet_ids
  role_ecs_task_arn      = var.role_ecs_task_arn
  role_ecs_task_exec_arn = var.role_ecs_task_exec_arn
  tags                   = var.tags
  target_group_arn       = aws_lb_target_group.ccs_intranet.arn
  vpc_id                 = var.vpc_id
}
