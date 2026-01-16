terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
  backend "s3"{
    bucket = "buckect-98bd761728910663"
    key = "backend.tfstate"
    region = "ap-south-1"
    
  }
}


provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "myserver" {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"
    tags = {
        Name = "SampleServer"
    }
  
}