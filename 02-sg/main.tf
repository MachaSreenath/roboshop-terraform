module "vpn" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_vpc.default.id
  sg_description = "Security group for VPN"
  sg_name = "vpn"
  # sg_ingress_rules = var.vpn_sg_ingress_rules
}

module "mongodb" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for mongodb"
  sg_name = "mongodb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "redis" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for redis"
  sg_name = "redis"
  # sg_ingress_rules = var.redis_sg_ingress_rules
}

module "mysql" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for mysql"
  sg_name = "mysql"
  # sg_ingress_rules = var.mysql_sg_ingress_rules
}

module "rabbitmq" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for rabbitmq"
  sg_name = "rabbitmq"
  # sg_ingress_rules = var.rabbitmq_sg_ingress_rules
}

module "catalogue" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for catalogue"
  sg_name = "catalogue"
  # sg_ingress_rules = var.catalogue_sg_ingress_rules
}

module "user" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for user"
  sg_name = "user"
  # sg_ingress_rules = var.user_sg_ingress_rules
}

module "cart" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for cart"
  sg_name = "cart"
  # sg_ingress_rules = var.cart_sg_ingress_rules
}

module "shipping" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for shipping"
  sg_name = "shipping"
  # sg_ingress_rules = var.shipping_sg_ingress_rules
}

module "payment" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for payment"
  sg_name = "payment"
  # sg_ingress_rules = var.payment_sg_ingress_rules
}

module "web" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for web"
  sg_name = "web"
  # sg_ingress_rules = var.web_sg_ingress_rules
}

#openvpn
resource "aws_security_group_rule" "vpn_home" {
  security_group_id = module.vpn.sg_id
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"] #ideally your home public ip address, but it frequently changes 
}


# mongodb accepting connections from catalogue instance 
resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  security_group_id = module.redis.sg_id
}