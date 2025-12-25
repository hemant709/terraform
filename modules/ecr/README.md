# ECR Module

Creates an Amazon ECR repository with optional lifecycle policy and scanning.

Usage:

```hcl
module "ecr" {
  source = "../modules/ecr"
  name   = "my-app-repo"
  scan_on_push = true
}
```

Outputs:
- `repository_url`, `repository_id`

Commands:
- terraform init
- terraform plan
- terraform apply
