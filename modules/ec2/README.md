# EC2 Module

This module creates an AWS EC2 instance and optional related resources (security group, EBS volumes).

## 🔧 Prerequisites

- Terraform 1.0+ (or compatible)
- AWS credentials configured (environment variables, shared credentials file, or IAM role)
- `provider "aws"` configured in the calling module

## 📦 Module files

- `ec2.tf` - EC2 instance, optional SG, EBS resources
- `variables.tf` - Module inputs
- `locals.tf` - Local computed values
- `data.tf` - AMI lookup data source
- `outputs.tf` - Module outputs

## ✅ Usage example

```hcl
provider "aws" {
  region = "us-east-1"
}

module "web" {
  source = "../modules/ec2"

  name          = "web-server"
  instance_type = "t3.small"
  ami           = "" # leave empty to use latest Amazon Linux 2 by default
  key_name      = "my-key"
  create_security_group = true
  ssh_cidr      = "203.0.113.0/24"
  tags = {
    Environment = "dev"
    Owner       = "team"
  }
}
```

## ⚙️ Commands

- Initialize: `terraform init`
- Plan: `terraform plan -var-file="vars.tfvars"`
- Apply: `terraform apply -var-file="vars.tfvars"`
- Destroy: `terraform destroy`

## 📌 Notes & Tips

- If you want to use a specific AMI, set `ami` to its id. Otherwise the module will lookup the most recent AMI matching `ami_name_regex` and `ami_owner`.
- The module will create a security group only if `vpc_security_group_ids` is empty and `create_security_group = true`.
- Opening SSH (`allow_ssh`) defaults to `true` and `ssh_cidr` defaults to `0.0.0.0/0` — change these values for production.

## Inputs

See `variables.tf` for a complete list of inputs and default values.

## Outputs

- `instance_id` - EC2 instance ID
- `instance_public_ip` - Public IP (if assigned)
- `instance_private_ip` - Private IP
- `instance_public_dns` - Public DNS
- `security_group_ids` - Security group IDs attached to instance
- `ami_used` - AMI id used

---