terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
    profile = "default"
    region = var.region 
}

resource "aws_instance" "example" {
    ami = "ami-0cc75a8978fbbc969"
    instance_type = "t2.micro"
}