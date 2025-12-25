# EKS Module

Creates an EKS cluster and a managed node group with basic IAM roles.

Usage:

```hcl
module "eks" {
  source = "../modules/eks"
  name   = "my-eks"
  subnet_ids = module.vpc.private_subnet_ids
}
```

Outputs:
- `cluster_id`, `cluster_endpoint`, `cluster_certificate_authority_data`, `node_group_name`

Notes:
- This module creates basic IAM roles and uses managed node groups. For more advanced setups (Fargate, custom AMIs), extend the module.

Commands:
- terraform init
- terraform plan
- terraform apply
