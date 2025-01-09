module "mongodb" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for Mongodb"
  sg_name = "mongodb"
  sg_ingress_rules = var.mongodb_sg_ingress_rules
}