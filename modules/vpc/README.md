# VPC Module

Creates a VPC with public and private subnets, an Internet Gateway, NAT Gateways (optional), and route tables.

## 🔧 Prerequisites
- Terraform 1.0+
- AWS provider configured

## Usage example

```hcl
module "vpc" {
  source = "../modules/vpc"
  name   = "my-vpc"
  cidr   = "10.1.0.0/16"
}
```

Commands:
- terraform init
- terraform plan
- terraform apply

Outputs:
- `vpc_id`, `public_subnet_ids`, `private_subnet_ids`, `nat_gateway_ids`, `internet_gateway_id`

Notes:
- By default the module creates 2 public and 2 private subnets; you can customize `public_subnet_cidrs` and `private_subnet_cidrs`.
