terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 2.0.0"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
}

# Setup Security Group
resource "aws_security_group" "jump" {
  name        = "jump-sg"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jump Security Group"
  }
}

# Setup jump instance
resource "aws_instance" "jump" {
  depends_on = [
    aws_security_group.jump
  ]

  ami           = data.aws_ami.amzn2.id
  instance_type = var.instance_type
  key_name      = var.ssh_keyname

  source_dest_check = false
  vpc_security_group_ids = [
    aws_security_group.jump.id
  ]
  subnet_id = var.public_subnet_id

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo sysctl -w net.ipv4.ip_forward=1
    sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    sudo yum install iptables-services -y
    sudo service iptables save
  EOF

  tags = {
    Name = "Jump Instance"
  }
}
