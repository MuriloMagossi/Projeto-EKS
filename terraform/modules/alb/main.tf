module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = ">= 9.0"

  name    = "my-alb"
  vpc_id  = var.vpc_id
  subnets = var.public_subnet_ids

  # Grupo de Segurança
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "Tráfego web HTTP"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "Tráfego web HTTPS"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "10.0.0.0/16"
    }
  }

  access_logs = {
    bucket = "terraform-state-eks-magossi"
  }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    ex-https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012" # TODO: Alterar para o certificado real
      forward = {
        target_group_key = "ex-instance"
      }
    }
  }

  target_groups = []

  tags = merge(var.common_tags, {
    Environment = "dev"
    Project     = "EKS-Terraform"
  })
}
