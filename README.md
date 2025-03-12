# AWS CodePipeline for Wagtail Deployment

This repository contains an **AWS CloudFormation template** and **AWS CodeBuild build specification** to automate the deployment of a **Wagtail application** to **Amazon ECS** using **AWS CodePipeline** and **GitHub integration**.



# Code Build/Deploy

This README provides instructions for using the build specification for building and deploying Docker images using Amazon ECR and ECS.

## Build Specification Version

This project uses buildspec version **0.2** for better compatibility.

## Build Phases

### Pre-build Phase

In the pre-build phase, the system logs in to Amazon ECR using the credentials for the specified AWS account and region:
bash echo "Logging in to Amazon ECR…" aws ecr get-login-password --region $DEFAULTAWSREGION | docker login --username AWS --password-stdin $AWSACCOUNTID.dkr.ecr.$DEFAULTAWSREGION.amazonaws.com
### Build Phase

During the build phase, the Docker image is built and an `imagedefinitions.json` file is created:
bash echo "[Build phase]" echo "Building the Docker image…" docker build -t $IMAGEREPOURI:$IMAGETAG . # Build Docker image with specified tag echo "Creating imagedefinitions.json…" printf '[{"name":"%s","imageUri":"%s"}]' "$IMAGEREPOURI:$IMAGETAG" "$IMAGEREPOURI:$IMAGE_TAG" > imagedefinitions.json # Create the image definitions JSON file
### Post-build Phase

In the post-build phase, the Docker image is pushed to Amazon ECR and the ECS service is updated:
bash echo "Pushing the Docker image to Amazon ECR…" docker push $IMAGEREPOURI:$IMAGETAG # Push the Docker image to ECR echo "Updating ECS service…" aws ecs update-service --cluster $ECSCLUSTER --service $ECSSERVICE --task-definition $ECSTASK_DEFINITION --force-new-deployment # Update ECS service
## Artifacts

The following artifact is specified for the next stage:

- `imagedefinitions.json`

This file contains the image definitions needed for the deployment phase.

## Environment Variables

Ensure to set the following environment variables in your CI/CD pipeline:

- `DEFAULT_AWS_REGION`: The region for your AWS account.
- `AWS_ACCOUNT_ID`: Your AWS account ID.
- `IMAGE_REPO_URI`: The URI of the Docker image repository in ECR.
- `IMAGE_TAG`: The tag for the Docker image.
- `ECS_CLUSTER`: The name of your ECS cluster.
- `ECS_SERVICE`: The name of your ECS service.
- `ECS_TASK_DEFINITION`: The name of your ECS task definition.

## Usage

Follow the build phases as specified above. Make sure all environment variables are set correctly before initiating the build process.

For further assistance or issues, please consult the AWS documentation on [ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html) and [ECS](https://docs.aws.amazon.com/AmazonECS/latest/userguide/what-is-ecs.html).


