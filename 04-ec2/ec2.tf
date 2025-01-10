module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-mongodb"
  instance_type = "t3.small"
  vpc_security_group_ids = []
}