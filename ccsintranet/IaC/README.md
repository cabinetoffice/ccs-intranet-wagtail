# CCS Intranet Project - CloudFormation Template

## Overview

This repository contains a CloudFormation template that sets up a high availability Wagtail CMS using AWS ECS Fargate. The template is parameterized to allow customization of various components, ensuring a flexible and scalable deployment.

## Purpose

The CloudFormation template automates the deployment of resources required to run the Wagtail CMS, including:

- VPC and subnets
- RDS database instance
- ECS cluster and task definition
- Application Load Balancer (ALB)
- WAF (Web Application Firewall) configuration

## Components

### Parameters

The following parameters can be customized when deploying the CloudFormation stack:

- `RDSPassword`: Password for the RDS instance (min length: 8, max length: 41)
- `RDSUsername`: Username for the RDS instance (default: `masteruser`)
- `RDSDBName`: Database name for the RDS instance (default: `ccsintranetapp`)
- `DockerImage`: Docker image for the ECS task (default: `480535739673.dkr.ecr.eu-west-2.amazonaws.com/ccs-intranet-dev:latest`)
- `VPCCIDR`: CIDR block for the VPC (default: `10.3.0.0/16`)
- Subnet CIDRs for public and private subnets.
- `DBInstanceType`: Type of the RDS instance (default: `db.r5.large`)
- `WAFWebACLParam`: ARN of the WAF Web ACL
- `YourCertificateArn`: ARN of the ACM certificate for the ALB
- Additional settings for Django and resource tagging.

### Resources

The following resources are created and configured by the template:

- **VPC and Subnets**: A VPC with public and private subnets for separating different resource types.
- **Internet Gateway**: For internet access from public subnets.
- **NAT Gateway**: To allow private subnets to access the internet securely.
- **RDS Instance**: Managed PostgreSQL database instance.
- **Security Groups**: For controlling network access to the RDS instance and ALB.
- **Application Load Balancer (ALB)**: To distribute incoming application traffic across multiple targets.
- **ECS Cluster and Service**: Hosting the Wagtail application using ECS Fargate for serverless container management.
- **WAF**: To protect the application from common web exploits.

### Deployment Instructions

1. **Prerequisites**:
   - Ensure you have the necessary permissions to deploy CloudFormation stacks in your AWS account.
   - AWS CLI or Management Console access.

2. **Deployment**:
   - Navigate to the AWS CloudFormation console.
   - Choose **Create Stack** > **With new resources (standard)**.
   - Upload this template file, or point to its URL (if hosted).
   - Provide the required parameters.
   - Review and create the stack.

3. **Access**:
   - After the stack creation is complete, retrieve the ALB URL to access the Wagtail CMS.

### Notes

- Ensure compliance with security policies regarding the management of sensitive parameters such as database passwords.
- Update the template as necessary to reflect any changes in project requirements or AWS best practices.

### Contributing

Contributions to improve the CloudFormation template and its associated documentation are welcome. Please submit a pull request or raise an issue for discussions.
