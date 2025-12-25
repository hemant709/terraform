# S3 Module

Creates an S3 bucket with secure defaults (block public access, encryption, versioning) and optional lifecycle rules.

## Usage

```hcl
module "bucket" {
  source = "../modules/s3"
  name   = "my-bucket"
  bucket_name = "" # leave empty to generate
  versioning = true
  server_side_encryption = "AES256"
}
```

Commands:
- terraform init
- terraform plan
- terraform apply

Outputs:
- `bucket_id`, `bucket_arn`, `bucket_domain_name`

Notes:
- To use KMS encryption set `server_side_encryption = "aws:kms"` and attach a KMS key resource yourself.
