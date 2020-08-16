terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
    profile = "default"
    region = "ap-northeast-1"
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-getting-started-guide-nxzh-01"
  acl    = "private"
}

resource "aws_instance" "example" {
    ami = "ami-0cc75a8978fbbc969"
    instance_type = "t2.micro"
    depends_on = [aws_s3_bucket.example]
}

resource "aws_instance" "another" {
  ami = "ami-0cc75a8978fbbc969"
  instance_type = "t2.micro"
}
