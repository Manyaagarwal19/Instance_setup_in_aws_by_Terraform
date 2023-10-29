variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "aws_subnet_cidr_block" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "aws_subnet_az" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "aws_subnet_name" {
  default = ["subnet1", "subnet2"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_ami" {
  default = ["ami-099b3d23e336c2e83", "ami-008b85aa3ff5c1b02"]
}

variable "instance_name" {
  default = ["os1", "os2"]
}

variable "aws_security_group_name" {
  default = "mysg"
}

variable "ingress_port" {
  default = [80, 22, 8081, 8080]
}

variable "ingress_protocol" {
  default = "tcp"
}

variable "ingress_cidr_block" {
  default = ["0.0.0.0/0"]
}

variable "egress_from_port" {
  default = "0"
}

variable "egress_to_port" {
  default = "0"
}

variable "egress_protocol" {
  default = "-1"
}

variable "egress_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  default = ["::/0"]
}

variable "aws_route_table_cidr_block" {
  default = "0.0.0.0/0"
}


