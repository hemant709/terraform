# Route Table Module

Creates a route table in the specified VPC and associates it with given subnets; supports creating custom routes.

Usage example:

```hcl
module "rt" {
  source = "../modules/route_table"
  name   = "private-rt"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  routes = [
    { destination_cidr_block = "0.0.0.0/0", nat_gateway_id = module.vpc.nat_gateway_ids[0] }
  ]
}
```

Outputs:
- `route_table_id`, `associations`

Commands:
- terraform init
- terraform plan
- terraform apply
