# Kinesis Module

Creates a Kinesis stream.

Usage:

```hcl
module "stream" {
  source = "../modules/kinesis"
  name   = "events"
  shard_count = 2
  retention_period_hours = 48
}
```

Outputs:
- `stream_name`, `stream_arn`

Commands:
- terraform init
- terraform plan
- terraform apply
