# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "phimm-cicd"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "us-east-2"
}

# Create Public s3 bucket
resource "aws_s3_bucket" "default" {
  bucket = "phimm-test-bucket"
  acl    = "public"
  tags = {
    Name        = "prisma"
    Environment = "Dev"
  }
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = ami-0fc20dd1da406780b
  count                  = 1
  key_name               = jenkins
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
