locals {
  version_app             = "latest"
  version_postgres_engine = "15.6"

  aws_region  = "eu-west-2"
  cidr_b_dev  = 2
  cidr_b_test = 3
  cidr_b_prod = 1

  vpn_ip_ranges_cabinet_office = "51.149.8.0/25"
  vpn_ip_ranges_goaco          = "165.232.98.44/32"
  allowed_ip_ranges = [
    local.vpn_ip_ranges_cabinet_office,
    local.vpn_ip_ranges_goaco,
  ]

  environment = get_env("TG_SUB_ENVIRONMENT", "test")
  environments = {
    test = {
      cidr_block             = "10.${local.cidr_b_test}.0.0/16"
      name                   = "test"
      postgres_instance_type = "db.t3.micro"
      private_subnets = [
        "10.${local.cidr_b_test}.101.0/24", "10.${local.cidr_b_test}.102.0/24", "10.${local.cidr_b_test}.103.0/24"
      ]
      public_subnets = [
        "10.${local.cidr_b_test}.1.0/24", "10.${local.cidr_b_test}.2.0/24", "10.${local.cidr_b_test}.3.0/24"
      ]
      redis_node_type       = "cache.t4g.micro"
      service_cpu           = 512
      service_desired_count = 1
      service_memory        = 1024
    }
    preprod = {
      cidr_block             = "10.${local.cidr_b_dev}.0.0/16"
      name                   = "preprod"
      postgres_instance_type = "db.t4g.Medium"
      private_subnets = [
        "10.${local.cidr_b_dev}.101.0/24", "10.${local.cidr_b_dev}.102.0/24", "10.${local.cidr_b_dev}.103.0/24"
      ]
      public_subnets = [
        "10.${local.cidr_b_dev}.1.0/24", "10.${local.cidr_b_dev}.2.0/24", "10.${local.cidr_b_dev}.3.0/24"
      ]
      redis_node_type       = "cache.t4g.micro"
      service_desired_count = 1
      service_cpu           = 1024
      service_desired_count = 2
      service_memory        = 2048
    }

    prod = {
      cidr_block             = "10.${local.cidr_b_prod}.0.0/16"
      name                   = "production"
      postgres_instance_type = "db.t4g.Medium"
      private_subnets = [
        "10.${local.cidr_b_prod}.101.0/24", "10.${local.cidr_b_prod}.102.0/24", "10.${local.cidr_b_prod}.103.0/24"
      ]
      public_subnets = [
        "10.${local.cidr_b_prod}.1.0/24", "10.${local.cidr_b_prod}.2.0/24", "10.${local.cidr_b_prod}.3.0/24"
      ]
      redis_node_type       = "cache.t4g.micro"
      service_cpu           = 1024
      service_desired_count = 2
      service_memory        = 2048
    }
  }

  product_name          = "CCS Intranet"
  product_resource_name = "ccs-intranet"
  product_subdomain     = "ccsintranet"
  civilservice_domain   = "civilservice.gov.uk"

  domains = {
    civilservice_gov_uk            = "${local.civilservice_domain}"
    ccs_intranet_internal   = "${local.product_subdomain}.internal"
    ccs_intranet_public     = "${local.product_subdomain}.${local.civilservice_domain}"
    ccs_intranet_public_env = "${local.environment}.${local.product_subdomain}.${local.civilservice_domain}"
  }

  tfstate_bucket = "tfstate-ccs-intranet-${local.environment}-${get_aws_account_id()}"
  tfstate_key    = "${path_relative_to_include()}/terraform.tfstate"
  tags = {
    environment    = local.environment
    managed_by     = "terragrunt"
    state_location = "${local.tfstate_bucket}"
  }

  ports = {
    http  = 80
    https = 443
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket                = local.tfstate_bucket
    disable_bucket_update = true
    dynamodb_table        = "terraform-locks"
    encrypt               = true
    key                   = local.tfstate_key
    region                = local.aws_region
  }
  generate = {
    path      = "remote_state.tf"
    if_exists = "overwrite"
  }
}

generate provider {
  path      = "temp_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("../providers.tf")
}

inputs = {
  allowed_ip_ranges       = local.allowed_ip_ranges
  aws_region              = local.aws_region
  cpu                     = local.environments[local.environment].service_cpu
  desired_count           = local.environments[local.environment].service_desired_count
  environment             = local.environment
  memory                  = local.environments[local.environment].service_memory
  port_http               = local.ports.http
  port_https              = local.ports.https
  postgres_instance_type  = local.environments[local.environment].postgres_instance_type
  product_resource_name   = local.product_resource_name
  product_subdomain       = local.product_subdomain
  tags                    = local.tags
  tfstate_bucket_name     = local.tfstate_bucket
  version_app             = local.version_app
  version_postgres_engine = local.version_postgres_engine
  vpc_cidr                = local.environments[local.environment].cidr_block
  vpc_private_subnets     = local.environments[local.environment].private_subnets
  vpc_public_subnets      = local.environments[local.environment].public_subnets
}

terraform {
  extra_arguments disable_input {
    commands  = get_terraform_commands_that_need_input()
    arguments = ["-input=false"]
  }
}
