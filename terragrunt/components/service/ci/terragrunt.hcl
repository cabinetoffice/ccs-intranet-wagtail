terraform {
  source = "../../../modules//ci"
}

include {
  path = find_in_parent_folders()
}

locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  core_vars   = read_terragrunt_config(find_in_parent_folders("service.hcl"))

  tags = merge(
    local.global_vars.inputs.tags,
    local.core_vars.inputs.tags,
    {
      component = "ci"
    }
  )
}

dependency common_networking {
  config_path = "../../common/networking"
  mock_outputs = {
    vpce_s3_prefix_list_id = "mock"
  }
}

dependency core_iam {
  config_path = "../../core/iam"
  mock_outputs = {
    ci_build_role_arn     = "mock"
    ci_build_role_name    = "mock"
    ci_pipeline_role_arn  = "mock"
    ci_pipeline_role_name = "mock"
  }
}

dependency core_networking {
  config_path = "../../core/networking"
  mock_outputs = {
    private_subnet_ids = "mock"
    vpc_id             = "mock"
  }
}

dependency core_security_groups {
  config_path = "../../core/security-groups"
  mock_outputs = {
    ci_build_sg_id            = "mock"
    vpce_ecr_api_sg_id        = "mock"
    vpce_ecr_dkr_sg_id        = "mock"
    vpce_s3_sg_id             = "mock"
    vpce_secretsmanager_sg_id = "mock"
  }
}


inputs = {
  tags = local.tags

  ci_build_role_arn     = dependency.core_iam.outputs.ci_build_role_arn
  ci_build_role_name    = dependency.core_iam.outputs.ci_build_role_name
  ci_pipeline_role_arn  = dependency.core_iam.outputs.ci_pipeline_role_arn
  ci_pipeline_role_name = dependency.core_iam.outputs.ci_pipeline_role_name

  vpce_s3_prefix_list_id = dependency.common_networking.outputs.vpce_s3_prefix_list_id

  private_subnet_ids = dependency.core_networking.outputs.private_subnet_ids
  vpc_id             = dependency.core_networking.outputs.vpc_id

  ci_build_sg_id            = dependency.core_security_groups.outputs.ci_build_sg_id
  vpce_ecr_api_sg_id        = dependency.core_security_groups.outputs.vpce_ecr_api_sg_id
  vpce_ecr_dkr_sg_id        = dependency.core_security_groups.outputs.vpce_ecr_dkr_sg_id
  vpce_logs_sg_id           = dependency.core_security_groups.outputs.vpce_logs_sg_id
  vpce_s3_sg_id             = dependency.core_security_groups.outputs.vpce_s3_sg_id
  vpce_secretsmanager_sg_id = dependency.core_security_groups.outputs.vpce_secretsmanager_sg_id
}
