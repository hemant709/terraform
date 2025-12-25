provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
  name   = "example-vpc"
}

module "sg" {
  source = "../../modules/security_group"
  name   = "example-sg"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    { from_port=80, to_port=80, protocol="tcp", cidr_blocks=["0.0.0.0/0"] }
  ]
}

module "alb" {
  source = "../../modules/load_balancer"
  name = "example-alb"
  subnet_ids = module.vpc.public_subnet_ids
  security_groups = [module.sg.security_group_id]
  listener_port = 80
}

module "ecr" {
  source = "../../modules/ecr"
  name = "example-app"
}

module "ecs" {
  source = "../../modules/ecs"
  name   = "example-ecs"
  create_cluster = true
  enable_fargate = true
  container_definitions = file("./container-definitions.json")
  desired_count = 1
  subnet_ids = module.vpc.private_subnet_ids
  security_groups = [module.sg.security_group_id]
}
