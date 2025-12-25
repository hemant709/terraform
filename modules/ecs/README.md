# ECS Module

Creates an ECS Cluster, task execution role, optional task definition and service (Fargate or EC2).

Usage:

```hcl
module "ecs" {
  source = "../modules/ecs"
  name   = "my-ecs"
  create_cluster = true
  enable_fargate = true
  container_definitions = file("container-definitions.json")
  desired_count = 1
  subnet_ids = module.vpc.private_subnet_ids
  security_groups = [module.sg.security_group_id]
}
```

Notes:
- Provide `container_definitions` as a JSON string for task definitions.
- The module creates a simple execution role and attaches the managed `AmazonECSTaskExecutionRolePolicy`.

Outputs:
- `cluster_id`, `task_definition_arn`, `service_name`

Commands:
- terraform init
- terraform plan
- terraform apply
