provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main-VPC"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_a_cidr_block
  availability_zone       = var.subnet_a_az
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-A"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_b_cidr_block
  availability_zone       = var.subnet_b_az
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-B"
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_c_cidr_block
  availability_zone       = var.subnet_c_az
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet-A"
  }
}

resource "aws_subnet" "subnet_d" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_d_cidr_block
  availability_zone       = var.subnet_d_az
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet-B"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet-Gateway"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet_a.id
  depends_on    = [aws_internet_gateway.internet_gateway]
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_iam_role" "eks_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [ {
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_eks_cluster" "eks" {
  name     = "web-app-cluster"
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_c.id,
      aws_subnet.subnet_d.id
    ]
  }
}

resource "aws_security_group" "eks_sg" {
  vpc_id = aws_vpc.main.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "EKS-Security-Group"
  }
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_security_group" {
  value = aws_security_group.eks_sg.id
}
