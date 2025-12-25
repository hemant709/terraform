# Basic example

This example demonstrates how to use several modules together: VPC, Security Group, ALB, ECR, ECS.

Steps:

1. cd examples/basic
2. terraform init
3. terraform plan
4. terraform apply

The example uses a public nginx image for the ECS task. Replace the `container-definitions.json` with your own definitions or build and push images into the created ECR repository.
