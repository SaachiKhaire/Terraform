terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


#Security group
data "aws_security_group" "name" {
  tags = {
    Name = "sg"
  }
}

#VPC Id
data "aws_vpc" "name" {
  tags = {
    ENV  = "PROD"
    Name = "myvpc"
  }
}

#AZ 
data "aws_availability_zones" "names" {
  state = "available"
}

#Subnet ID
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    Name = "private-subnet"
  }
}


resource "aws_instance" "myserver" {
  ami             = "ami-0ced6a024bb18ff2e"
  instance_type   = "t3.micro"
  subnet_id       = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]

  tags = {
    Name = "SampleServer"
  }
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}

#To get the account details
data "aws_caller_identity" "name" {
}
data "aws_region" "name" {
}

output "caller_info" {
  value = data.aws_caller_identity.name
}

output "region_name" {
  value = data.aws_region.name
}

output "security_group" {
  value = data.aws_security_group.name.id
}
output "vpc_id" {
  value = data.aws_vpc.name.id
}