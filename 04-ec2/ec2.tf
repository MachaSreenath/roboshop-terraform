module "mongodb" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-mongodb"
    instance_type = "t3.small"
    vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
    subnet_id = local.database_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "mongodb"
      },
      {
        Name = "${local.ec2_name}-mongodb"
      }
  )
}

module "redis" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-redis"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
    subnet_id = local.database_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "redis"
      },
      {
        Name = "${local.ec2_name}-redis"
      }
  )
}

module "mysql" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-mysql"
    instance_type = "t3.small"
    vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
    subnet_id = local.database_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "mysql"
      },
      {
        Name = "${local.ec2_name}-mysql"
      }
  )
}

module "rabbitmq" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-rabbitmq"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
    subnet_id = local.database_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "rabbitmq"
      },
      {
        Name = "${local.ec2_name}-rabbitmq"
      }
  )
}

module "catalogue" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-catalogue"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
    subnet_id = local.private_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "catalogue"
      },
      {
        Name = "${local.ec2_name}-catalogue"
      }
  )
}

module "user" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-user"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value]
    subnet_id = local.private_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "user"
      },
      {
        Name = "${local.ec2_name}-user"
      }
  )
}

module "cart" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-cart"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value]
    subnet_id = local.private_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "cart"
      },
      {
        Name = "${local.ec2_name}-cart"
      }
  )
}

module "shipping" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-shipping"
    instance_type = "t3.small"
    vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value]
    subnet_id = local.private_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "shipping"
      },
      {
        Name = "${local.ec2_name}-shipping"
      }
  )
}

module "payment" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-payment"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.payment_sg_id.value]
    subnet_id = local.private_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "payment"
      },
      {
        Name = "${local.ec2_name}-payment"
      }
  )
}

module "web" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.centos8.id
    name = "${local.ec2_name}-web"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.web.value]
    subnet_id = local.public_subnet_id
    tags = merge(
      var.common_tags,
      {
        Component = "web"
      },
      {
        Name = "${local.ec2_name}-web"
      }
  )
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name    = "mongodb.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.mongodb.private_ip}",
      ]
    },
    {
      name    = "redis.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.redis.private_ip}",
      ]
    },
    {
      name    = "mysql.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.mysql.private_ip}",
      ]
    },
    {
      name    = "rabbitmq.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.rabbitmq.private_ip}",
      ]
    },
    {
      name    = "catalogue.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.catalogue.private_ip}",
      ]
    },
    {
      name    = "user.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.user.private_ip}",
      ]
    },
    {
      name    = "cart.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.cart.private_ip}",
      ]
    },
    {
      name    = "shipping.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.shipping.private_ip}",
      ]
    },
    {
      name    = "payment.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.payment.private_ip}",
      ]
    },
    {
      name    = "web.forpractice.uno"
      type    = "A"
      ttl     = 1
      records = [
        "${module.web.private_ip}",
      ]
    },
  ]
}