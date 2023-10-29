provider "aws" {
  region  = var.region
  profile = "default"

}

resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "createdvpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_subnet" "mysubnet" {
  count             = length(var.aws_subnet_cidr_block)
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = element(var.aws_subnet_cidr_block, count.index)
  availability_zone = element(var.aws_subnet_az, count.index)
  #map_public_ip_on_launch = True
  tags = {
    Name = var.aws_subnet_name[count.index]
  }
}

resource "aws_instance" "web01" {
  count = length(var.instance_ami)

  ami                    = var.instance_ami[count.index]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.mysubnet[count.index].id
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  tags = {
    Name = var.instance_name[count.index]
  }
}

resource "aws_security_group" "allow_ssh" {
  name   = var.aws_security_group_name
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = var.ingress_port
    #   iterator = port
    content {
      description = "shhforaws"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.ingress_protocol
      cidr_blocks = var.ingress_cidr_block
    }
  }
  egress {
    from_port        = var.egress_from_port
    to_port          = var.egress_to_port
    protocol         = var.egress_protocol
    cidr_blocks      = var.egress_cidr_blocks
    ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks

  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.aws_route_table_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "rtasso" {
  count          = length(var.aws_subnet_cidr_block)
  subnet_id      = aws_subnet.mysubnet[count.index].id
  route_table_id = aws_route_table.rt.id
}


