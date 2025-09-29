module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 6.3.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["sa-east-1a", "sa-east-1b", "sa-east-1c"] # região correta
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Para ALB e NAT Gateway
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] # Para os nós EKS

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "MyInternetGateway"
  } 
}
resource "aws_vpc_gateway_attachment" "attach" {
  vpc_id = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.gw.id
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # Rota padrão para a Internet
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet.id # Referencia uma sub-rede existente
  route_table_id = aws_route_table.public_rt.id
}