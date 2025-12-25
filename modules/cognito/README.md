# Cognito Module

Creates a Cognito User Pool and a User Pool Client; optionally creates an Identity Pool.

Usage:

```hcl
module "cognito" {
  source = "../modules/cognito"
  name   = "my-auth"
  create_identity_pool = true
}
```

Outputs:
- `user_pool_id`, `user_pool_client_id`, `identity_pool_id`

Notes:
- Extend password policy or add triggers as needed.

Commands:
- terraform init
- terraform plan
- terraform apply
