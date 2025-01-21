.PHONY: help ecs-apply ecs-apply-all ecs-plan ecs-plan-all ecs-state-list database-apply database-apply-all database-plan database-plan-all database-state-list iam-apply iam-apply-all iam-plan iam-plan-all iam-state-list ci-apply ci-apply-all ci-plan ci-plan-all ci-state-list networking-apply networking-apply-all networking-plan networking-plan-all networking-state-list security-groups-apply security-groups-apply-all security-groups-plan security-groups-plan-all security-groups-state-list

# Component directory paths
COMMON_NETWORKING_DIR := components/common/networking
CORE_NETWORKING_DIR := components/core/networking
CORE_IAM_DIR := components/core/iam
CORE_SECURITY_GROUPS_DIR := components/core/security-groups
SERVICE_CI_DIR := components/service/ci
SERVICE_DATABASE_DIR := components/service/database
SERVICE_ECS_DIR := components/service/ecs

# Common commands
TERRAGRUNT_APPLY := terragrunt apply -auto-approve
TERRAGRUNT_PLAN := terragrunt plan
TERRAGRUNT_RUN_ALL_APPLY := terragrunt run-all apply
TERRAGRUNT_RUN_ALL_PLAN := terragrunt run-all plan
TERRAGRUNT_STATE_LIST := terragrunt state list

help:
	@echo "Available components and relevant commands:"
	@grep --no-filename -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


common-networking-apply: ## Apply Terraform changes for Networking component
	@cd $(COMMON_NETWORKING_DIR) && $(TERRAGRUNT_APPLY)

common-networking-apply-all: ## Apply Terraform changes for Networking and all relevant components
	@cd $(COMMON_NETWORKING_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

common-networking-plan: ## Plan Terraform changes for Networking component
	@cd $(COMMON_NETWORKING_DIR) && $(TERRAGRUNT_PLAN)

common-networking-plan-all: ## Plan Terraform changes for Networking and all relevant components
	@cd $(COMMON_NETWORKING_DIR) && $(TERRAGRUNT_RUN_ALL_PLAN)

common-networking-state-list: ## List Terraform resources in state for Networking component
	@cd $(COMMON_NETWORKING_DIR) && $(TERRAGRUNT_STATE_LIST)

core-iam-apply: ## Apply Terraform changes for IAM component
	@cd $(CORE_IAM_DIR) && $(TERRAGRUNT_APPLY)

core-iam-apply-all: ## Apply Terraform changes for IAM and all relevant components
	@cd $(CORE_IAM_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

core-iam-plan: ## Plan Terraform changes for IAM component
	@cd $(CORE_IAM_DIR) && $(TERRAGRUNT_PLAN)

core-iam-plan-all: ## Plan Terraform changes for IAM and all relevant components
	@cd $(CORE_IAM_DIR) && $(TERRAGRUNT_RUN_ALL_PLAN)

core-iam-state-list: ## List Terraform resources in state for IAM component
	@cd $(CORE_IAM_DIR) && $(TERRAGRUNT_STATE_LIST)

core-networking-apply: ## Apply Terraform changes for Networking component
	@cd $(CORE_NETWORKING_DIR) && $(TERRAGRUNT_APPLY)

core-networking-apply-all: ## Apply Terraform changes for Networking and all relevant components
	@cd $(CORE_NETWORKING_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

core-networking-plan: ## Plan Terraform changes for Networking component
	@cd $(CORE_NETWORKING_DIR) && $(TERRAGRUNT_PLAN)

core-networking-plan-all: ## Plan Terraform changes for Networking and all relevant components
	@cd $(CORE_NETWORKING_DIR) && $(TERRAGRUNT_RUN_ALL_PLAN)

core-networking-state-list: ## List Terraform resources in state for Networking component
	@cd $(CORE_NETWORKING_DIR) && $(TERRAGRUNT_STATE_LIST)

core-security-groups-apply: ## Apply Terraform changes for Security Groups component
	@cd $(CORE_SECURITY_GROUPS_DIR) && $(TERRAGRUNT_APPLY)

core-security-groups-apply-all: ## Apply Terraform changes for Security Groups and all relevant components
	@cd $(CORE_SECURITY_GROUPS_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

core-security-groups-plan: ## Plan Terraform changes for Security Groups component
	@cd $(CORE_SECURITY_GROUPS_DIR) && $(TERRAGRUNT_PLAN)

core-security-groups-plan-all: ## Plan Terraform changes for Security Groups and all relevant components
	@cd $(CORE_SECURITY_GROUPS_DIR) && $(TERRAGRUNT_RUN_ALL_PLAN)

core-security-groups-state-list: ## List Terraform resources in state for Security Groups component
	@cd $(CORE_SECURITY_GROUPS_DIR) && $(TERRAGRUNT_STATE_LIST)

service-ci-apply: ## Apply Terraform changes for CI component
	@cd $(SERVICE_CI_DIR) && $(TERRAGRUNT_APPLY)

service-ci-apply-all: ## Apply Terraform changes for CI and all relevant components
	@cd $(SERVICE_CI_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

service-ci-plan: ## Plan Terraform changes for CI component
	@cd $(SERVICE_CI_DIR) && $(TERRAGRUNT_PLAN)

service-ci-plan-all: ## Plan Terraform changes for CI and all relevant components
	@cd $(SERVICE_CI_DIR) && $(TERRAGRUNT_RUN_ALL_PLAN)

service-ci-state-list: ## List Terraform resources in state for CI component
	@cd $(SERVICE_CI_DIR) && $(TERRAGRUNT_STATE_LIST)

service-database-apply: ## Apply Terraform changes for database component
	@cd $(SERVICE_DATABASE_DIR) && $(TERRAGRUNT_APPLY)

service-database-apply-all: ## Apply Terraform changes for database and all relevant components
	@cd $(SERVICE_DATABASE_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

service-database-plan: ## Plan Terraform changes for database component
	@cd $(SERVICE_DATABASE_DIR) && $(TERRAGRUNT_PLAN)

service-database-plan-all: ## Plan Terraform changes for database and all relevant components
	@cd $(SERVICE_DATABASE_DIR) && $(TERRAGRUNT_RUN_ALL_PLAN)

service-database-state-list: ## List Terraform resources in state for database component
	@cd $(SERVICE_DATABASE_DIR) && $(TERRAGRUNT_STATE_LIST)

service-ecs-apply: ## Apply Terraform changes for ECS component
	@cd $(SERVICE_ECS_DIR) && $(TERRAGRUNT_APPLY)

service-ecs-apply-all: ## Apply Terraform changes for ECS and all relevant components
	@cd $(SERVICE_ECS_DIR) && $(TERRAGRUNT_RUN_ALL_APPLY)

service-ecs-plan: ## Plan Terraform changes for ECS component
	@cd $(SERVICE_ECS_DIR) && $(TERRAGRUNT_PLAN)

service-ecs-plan-all: ## Plan Terraform changes for ECS and all relevant components
