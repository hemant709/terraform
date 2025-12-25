# API Gateway Module (HTTP API)

Creates an HTTP API (API Gateway v2) with optional CORS and routes.

Usage:

```hcl
module "api" {
  source = "../modules/api_gateway"
  name   = "my-api"
  cors = { allow_origins = ["*"] }
  routes = [
    { route_key = "GET /", target = "integrations/xyz" }
  ]
}
```

Outputs:
- `api_id`, `api_endpoint`

Notes:
- Integration targets must be created separately (Lambda, HTTP integration) and referenced in `routes`.

Commands:
- terraform init
- terraform plan
- terraform apply
