// EC2 module variables

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "ec2"
}

variable "ami" {
  description = "AMI id to use. If empty, module will lookup latest from filters below"
  type        = string
  default     = ""
}

variable "ami_owner" {
  description = "AMI owner (used when `ami` is not provided)"
  type        = string
  default     = "amazon"
}

variable "ami_name_regex" {
  description = "Name regex for AMI lookup when `ami` is not provided"
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2" // sensible default for Amazon Linux 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet id to launch the instance in (optional). If omitted and VPC/subnet lookups are required, pass explicitly via calling module)"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of existing security group IDs to attach. If empty and create_security_group is true, a new SG will be created"
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Whether to create a security group when no security group ids are provided"
  type        = bool
  default     = true
}

variable "allow_ssh" {
  description = "Whether the module should open SSH (port 22) on the created security group"
  type        = bool
  default     = true
}

variable "ssh_cidr" {
  description = "CIDR block allowed for SSH when `allow_ssh` is true"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "Existing key pair name to associate with the instance (optional)"
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP to the instance (only effective in a non-default subnet when using `network_interface` block)"
  type        = bool
  default     = true
}

variable "ebs_block_devices" {
  description = "EBS block devices definitions for extra volumes (list of maps with device_name, volume_size, volume_type, delete_on_termination)"
  type        = list(object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
  }))
  default = []
}

variable "root_block_device" {
  description = "Root block device config"
  type = object({
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
  })
  default = {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach (optional)"
  type        = string
  default     = ""
}

variable "tenancy" {
  description = "Tenancy option for the instance ('default' or 'dedicated')"
  type        = string
  default     = "default"
}

variable "disable_api_termination" {
  description = "Set to true to disable API termination of the instance"
  type        = bool
  default     = false
}
