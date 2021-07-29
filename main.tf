module "network_module" {
  source                          = "./modules/network"
  env                             = var.env
  name_tag                        = var.name_tag
  vpc_cidr_block                  = var.vpc_cidr_block
  availability_zone_1             = var.availability_zone_1
  availability_zone_2             = var.availability_zone_2
  public_subnet_1_cidr_block      = var.public_subnet_1_cidr_block
  public_subnet_2_cidr_block      = var.public_subnet_2_cidr_block
  private_subnet_1_nat_cidr_block = var.private_subnet_1_nat_cidr_block
  private_subnet_2_nat_cidr_block = var.private_subnet_2_nat_cidr_block
  private_subnet_3_cidr_block     = var.private_subnet_3_cidr_block
  private_subnet_4_cidr_block     = var.private_subnet_4_cidr_block
  private_subnet_5_cidr_block     = var.private_subnet_5_cidr_block
  private_subnet_6_cidr_block     = var.private_subnet_6_cidr_block
}

module "route_module" {
  source                 = "./modules/routes"
  env                    = var.env
  name_tag               = var.name_tag
  my_vpc_id              = module.network_module.my_vpc_id
  public_subnet1_id      = module.network_module.public_subnet1_id
  public_subnet2_id      = module.network_module.public_subnet2_id
  private_subnet1_nat_id = module.network_module.private_subnet1_nat_id
  private_subnet2_nat_id = module.network_module.private_subnet2_nat_id
  private_subnet3_id     = module.network_module.private_subnet3_id
  private_subnet4_id     = module.network_module.private_subnet4_id
  private_subnet5_id     = module.network_module.private_subnet5_id
  private_subnet6_id     = module.network_module.private_subnet6_id
}

module "security_groups_module" {
  source = "./modules/security_groups"
  env                    = var.env
  name_tag               = var.name_tag
  my_vpc_id              = module.network_module.my_vpc_id
  private_subnet_1_nat_cidr_block = var.private_subnet_1_nat_cidr_block
  private_subnet_2_nat_cidr_block = var.private_subnet_2_nat_cidr_block
}

module "app_module" {
  source = "./modules/app"
  env                    = var.env
  name_tag               = var.name_tag
  private_subnet1_nat_id      = module.network_module.private_subnet1_nat_id
  private_subnet2_nat_id      = module.network_module.private_subnet2_nat_id
  security_group_ec2_id = module.security_groups_module.security_group_ec2_id
}

module "lb_module" {
  source = "./modules/alb"
  env                    = var.env
  name_tag               = var.name_tag
  my_vpc_id              = module.network_module.my_vpc_id
  public_subnet1_id      = module.network_module.public_subnet1_id
  public_subnet2_id      = module.network_module.public_subnet2_id
  security_group_lb_id = module.security_groups_module.security_group_lb_id
  ec2_test1_id = module.app_module.ec2_test1_id
  ec2_test2_id = module.app_module.ec2_test2_id
}

module "rds_module" {
  source = "./modules/RDS"
  env                    = var.env
  name_tag               = var.name_tag
  private_subnet3_id     = module.network_module.private_subnet3_id
  private_subnet4_id     = module.network_module.private_subnet4_id
  security_group_rds_id = module.security_groups_module.security_group_rds_id
}
