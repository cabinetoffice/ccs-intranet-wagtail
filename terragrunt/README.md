# CCS Intranet Infrastructure

This code base is responsible for provisioning the AWS infrastructure needed to support the CCS Intranet application.

# Table of Contents
1. [Overview](#overview)
2. [Infrastructure Provisioning](#infrastructure-provisioning)
    - [How to use terragrunt in this project](#how-to-use-terragrunt-in-this-project)
        - [Check](#check)
        - [Run all](#run-all)
        - [Run Individual Components](#run-individual-components)
        - [Use Makefile targets](#use-makefile-targets)
3. [Application Deployment Process](#application-deployment-process)
4. [Diagrams](#diagrams)

## Overview

CCS Intranet operates within a single AWS account, hosting its application across three distinct AWS ECS clusters: Production, Pre-production, and Test.

Each cluster is provisioned within its dedicated Virtual Private Cloud (VPC), encompassing necessary dependencies like the Postgres database and Redis cache.

Certain dependencies, such as ECR, Secret Manager, or S3 buckets, reside outside the VPC. However, through the utilization of security groups and IAM roles, each cluster is confined to accessing only the relevant common resources.

Whenever changes are committed/pushed to the test, preprod, or prod branches of the repository, it triggers a CodePipeline process. This process builds the image and pushes it to the appropriate ECR for each cluster. Subsequently, this action triggers service deployments within the corresponding cluster.

Within each cluster, two services are operational. The first service, dubbed "leader," manages a single task responsible for seeding the database and executing migration scripts. The second service performs similar tasks but excludes database migration scripts. Notably, the test cluster solely operates a single task within the leader service.


## Infrastructure Provisioning

`.tool-versions` is essential for users leveraging tools like [asdf](https://asdf-vm.com/) or [mise](https://mise.jdx.dev/) to manage local installations of various tools.

[Terragrunt](https://terragrunt.gruntwork.io/) serves the purpose of maintaining Terraform configurations DRY (Don't Repeat Yourself).

An AWS Profiler such as [aws-profile](https://pypi.org/project/aws-profile/) or [aws-vault](https://github.com/99designs/aws-vault)
is indispensable for assuming the appropriate role required to provision resources managed by this codebase.\
The provided `goaco-admin` role has been utilized during development. _However, it's strongly recommended to create a specific role with limited privileges tailored to maintaining the required resources._

The target sub-environment can be specified using an environment variable named `TG_SUB_ENVIRONMENT`.

### How to use terragrunt in this project

#### Check

Ensure that your chosen profiler is properly configured and can assume the appropriate role by executing the `aws sts sts get-caller-identity` command.
For instance, in this example, we're using `aws-vault exec` (`ave`) to verify assuming the `goaco-admin` role using a profile named `goaco-co-admin`.

![Testing profile](../docs/images/confirm-aws-config.png)

#### Run all

Within the Terragrunt folder, executing the `terragrunt run-all` command enables the execution of Terraform commands like `plan` or `apply` across all components. If a target sub-environment isn't specified, it will default to the `test` sub-environment.

i.e. Plan all components for **Test** sub-environment
```shell
ave terragrunt run-all plan
```

![Testing profile](../docs/images/terragrunt-plan-all.png)

To target other sub-environments, simpley set the `TG_SUB_ENVIRONMENT`

i.e. Plan all components for **Pre-production** sub-environment
```shell
export TG_SUB_ENVIRONMENT=preprod
ave terragrunt run-all plan
```


i.e. Plan all components for **Production** sub-environment
```shell
export TG_SUB_ENVIRONMENT=prod
ave terragrunt run-all plan
```

> [!IMPORTANT]\
> When transitioning between sub-environments, it's imperative to clear the cache for smooth operation.
> Simply running the `delete_tf_cache.sh` script located in the `tools` directory should suffice.
> i.e. `./tools/delete_tf_cache.sh`

#### Run Individual Components

To work with individual components, navigate to their respective directories and execute Terraform commands using Terragrunt. For example, to plan against the `core-security group`, you would:

```shell
cd components/core/security-groups
ave terragrunt plan
```

This ensures that you're operating within the context of the specific component and running commands through Terragrunt, which manages Terraform configurations effectively.

#### Use Makefile targets

A Makefile containing commonly used commands has also been provided. For instance, to list the state of the `core-iam` component, rather than navigating to the folder and executing the Terragrunt command manually, you can simply run `make core-iam-state-list`. This command assumes the AWS role `core-iam` using `ave` for you.

![List state using make](../docs/images/make-state-list.png)

Executing `make` with no arguments displays the available targets:

![Make targets](../docs/images/make-targets.png)

## Application Deployment Process

Committing or pushing changes to the **test**, **preprod**, or **prod** branches initiates the corresponding CodePipeline jobs to build and push the image into the relevant Amazon ECR repository.\
We do not support specific tagging of images; instead, new images are tagged as `latest`.

Pushing these images to ECR triggers CloudWatch events, which in turn triggers service deployments for the relevant cluster associated with that branch. Therefore, whether you're building images locally and pushing them to ECR for test, preprod, or prod, it will also trigger a service deployment automatically.

## Diagrams

![AWS Infrastructure Overview](../docs/diagrams/aws-account-overview.svg)
