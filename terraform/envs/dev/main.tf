# Wires the modules together. Uncomment each block in its own PR (see docs/PR_PLAN.md).

module "network" { # PR 3
  source   = "../../modules/network"
  name     = "sre-portfolio"
  vpc_cidr = "10.20.0.0/16"
  azs      = ["${var.region}a", "${var.region}b"]
}

# module "compute" { # PR 4
#   source             = "../../modules/compute"
#   name               = "sre-portfolio"
#   vpc_id             = module.network.vpc_id
#   private_subnet_ids = module.network.private_subnet_ids
#   # compute owns ALL security groups (incl. the ALB's) to avoid a compute <-> edge cycle
# }

# module "edge" { # PR 5
#   source            = "../../modules/edge"
#   providers         = { aws = aws, aws.us_east_1 = aws.us_east_1 }
#   name              = "sre-portfolio"
#   vpc_id            = module.network.vpc_id
#   public_subnet_ids = module.network.public_subnet_ids
#   alb_sg_id         = module.compute.alb_sg_id
#   web_instance_ids  = module.compute.web_instance_ids
#   allowed_countries = var.allowed_countries
# }

# module "ecr" { # PR 8
#   source = "../../modules/ecr"
#   name   = "sre-portfolio-api"
# }