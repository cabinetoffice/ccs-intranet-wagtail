resource "aws_sfn_state_machine" "ecs_force_deploy" {
  name     = "${var.environment}-deployer"
  role_arn = var.role_ecs_deployer_step_function_arn
  tags     = var.tags

  definition = templatefile("${path.module}/templates/state-machine/deployment.json.tftpl", {
    cluster = aws_ecs_cluster.ccs_intranet.name,
    service = module.ccs_intranet_service.service_name
  })
}
