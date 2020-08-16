terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile    = "default"
  region = "ap-northeast-1"
}

resource "aws_key_pair" "example" {
  key_name   = "examplekey"
  public_key = file("./ssh/terraform.pub")
}

resource "aws_instance" "example" {
  key_name = aws_key_pair.example.key_name
  ami           = "ami-0cc75a8978fbbc969"
  instance_type = "t2.micro"
  security_groups = ["default", "sg_allow_web", "sg_ssh_allow"]
  

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./ssh/terraform")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}