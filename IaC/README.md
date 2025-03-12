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


# AWS CodePipeline CloudFormation Template for Wagtail Deployment

This AWS CloudFormation template provisions an **AWS CodePipeline** for deploying a Wagtail application to Amazon ECS using a **GitHub connector**.

## 🚀 Features

- **GitHub Integration**: Pulls source code from a specified GitHub repository.
- **CodeBuild Integration**: Builds the application using AWS CodeBuild.
- **Amazon ECS Deployment**: Deploys the containerized Wagtail application to ECS.
- **AWS IAM Roles**: Configures necessary permissions for CodePipeline and CodeBuild.
- **S3 Artifact Storage**: Uses an S3 bucket to store pipeline artifacts.
- **CodeStar Connection**: Manages secure authentication with GitHub.

## 🛠️ Prerequisites

Before deploying the CloudFormation stack, ensure you have:

- An **AWS account** with permissions to create IAM roles, S3 buckets, ECS services, and CodePipeline resources.
- An **AWS CodeStar Connection** configured to access your GitHub repository.
- An **Amazon ECR repository** to store your application container images.
- An **S3 bucket** for storing pipeline artifacts.
- A **Wagtail ECS Task Definition** and **ECS Cluster** in place.

## 📥 Parameters

| Parameter              | Description                                                   | Default Value |
|------------------------|---------------------------------------------------------------|--------------|
| `GitHubRepositoryOwner` | The owner of the GitHub repository (e.g., user)             | - |
| `GitHubRepositoryName` | The name of the GitHub repository                            | - |
| `GitHubBranch`        | The branch to deploy from                                    | `main` |
| `GitHubConnectionArn`  | The ARN of the AWS CodeStar GitHub connection                | - |
| `ContainerName`       | The name of the container in the ECS task definition         | `wagtail` |
| `ECSServiceName`      | The ECS service name                                         | `WagtailService` |
| `ECSClusterName`      | The ECS cluster where the service is located                | `WagtailCluster` |
| `ECSTaskDefinition`   | The ECS Task Definition ARN                                 | `WagtailTaskDefinition` |
| `ECRRepositoryName`   | The ECR repository name for the application container       | `ECRRepositoryName` |
| `ImageTag`           | The Docker image tag to use                                  | `latest` |
| `ArtifactBucketName`  | The S3 bucket for pipeline artifacts                        | - |
| `ECSExecutionRoleArn` | The IAM role ARN for ECS execution                          | - |

## ⚙️ Deployment Steps

1. **Create an AWS CodeStar Connection**  
   - Navigate to AWS CodePipeline → Connections.
   - Create a connection to your **GitHub repository**.
   - Note the **Connection ARN** to use in this template.

2. **Upload this template to AWS CloudFormation**  
   - Go to **AWS CloudFormation** in the AWS console.
   - Click **Create Stack → With new resources**.
   - Upload the `CCSIntranet-CodePipeline-Template.yml` file.
   - Provide the required parameters (GitHub details, ECS settings, IAM roles, etc.).
   - Click **Create Stack**.

3. **Monitor Stack Creation**  
   - Wait for CloudFormation to complete provisioning.
   - Check AWS CodePipeline to confirm the pipeline has been created.

4. **Trigger a Deployment**  
   - Push a change to the configured GitHub branch.
   - CodePipeline will **detect the change**, **build the application**, and **deploy it to ECS**.

## 🔍 Pipeline Stages

### 1️⃣ **Source Stage**
- Connects to **GitHub** via AWS CodeStar.
- Fetches the latest code from the specified branch.

### 2️⃣ **Build Stage**
- Uses **AWS CodeBuild** to:
  - Build the container image.
  - Push the image to **Amazon ECR**.

### 3️⃣ **Deploy Stage**
- Updates the **ECS Task Definition**.
- Triggers **Amazon ECS** to deploy the new application version.

## 🔐 Security Considerations

- The IAM roles provided in this template **grant permissions for AWS services**. Ensure they are **scoped minimally**.
- The **GitHub connection ARN** must be secured using **AWS Secrets Manager** or a **restricted IAM role**.

## 🏗️ Future Enhancements

- Add **unit tests** to CodeBuild.
- Implement **automated rollback** on failed deployments.
- Enable **AWS Lambda notifications** for pipeline failures.

## 📜 License

This project is licensed under the **MIT License**.

---

This README provides a **structured overview** of your AWS CodePipeline template, explaining how to deploy and configure it. Let me know if you need any modifications! 🚀

### Notes

- Ensure compliance with security policies regarding the management of sensitive parameters such as database passwords.
- Update the template as necessary to reflect any changes in project requirements or AWS best practices.

### Contributing

Contributions to improve the CloudFormation template and its associated documentation are welcome. Please submit a pull request or raise an issue for discussions.