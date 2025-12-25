// Data sources used by the EC2 module

// Look up AMI if `ami` is not provided
data "aws_ami" "selected" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_regex]
  }

  owners = [var.ami_owner]

  // Only used when var.ami == ""
  lifecycle {
    ignore_changes = [filter]
  }
}
