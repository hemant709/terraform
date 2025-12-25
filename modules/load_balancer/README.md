# Load Balancer Module (ALB)

Creates an Application Load Balancer, a target group, and a listener.

Usage:

```hcl
module "alb" {
  source = "../modules/load_balancer"
  name   = "web-alb"
  subnet_ids = module.vpc.public_subnet_ids
  security_groups = [module.sg.security_group_id]
  listener_port = 80
}
```

Outputs:
- `load_balancer_arn`, `load_balancer_dns_name`, `target_group_arn`

Notes:
- For HTTPS add a listener with certificate info (extension) and to route to HTTPS health checks.

Commands:
- terraform init
- terraform plan
- terraform apply
