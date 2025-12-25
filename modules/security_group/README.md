# Security Group Module

Creates a reusable security group with configurable ingress/egress rules.

Example:

```hcl
module "sg" {
  source = "../modules/security_group"
  name   = "web-sg"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    { from_port=80, to_port=80, protocol="tcp", cidr_blocks=["0.0.0.0/0"] },
    { from_port=443, to_port=443, protocol="tcp", cidr_blocks=["0.0.0.0/0"] }
  ]
}
```

Outputs:
- `security_group_id`, `security_group_arn`

Commands:
- terraform init
- terraform plan
- terraform apply
