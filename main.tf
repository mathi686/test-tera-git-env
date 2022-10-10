provider "aws" {
  region     = "us-east-2"
  access_key = "AKIASZTTQPYFNPGWZXS4"
  secret_key = "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"
}
resource "aws_vpc" "private-sub-testing" {
  cidr_block           = "${var.Vpc-CIDIR}"
  enable_dns_hostnames = "${var.True-Value}"
}
resource "aws_subnet" "PUBLIC" {
  vpc_id            = aws_vpc.private-sub-testing.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"
}
resource "aws_subnet" "PRIVATE" {
  vpc_id            = aws_vpc.private-sub-testing.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2b"
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.private-sub-testing.id
}
# Craeting route table and attaching IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.private-sub-testing.id
  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    name = "public"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.private-sub-testing.id


  tags = {
    name = "private"
  }
}
resource "aws_route_table_association" "rtassosation" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.PUBLIC.id
}
resource "aws_route_table_association" "rtprivate" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.PRIVATE.id
}
module "sec-gp" {
  source = "./modules/security_moudule.tf"
  depends_on = [a]
}
resource "aws_instance" "public" {
  ami                         = "ami-0568773882d492fc8"
  subnet_id                   = aws_subnet.PUBLIC.id
  availability_zone           = "us-east-2a"
  key_name                    = "neelakey"
  vpc_security_group_ids = [aws_security_group.my-sec-gp.id]
  associate_public_ip_address = "${var.True-Value}"
  instance_type               = var.type
  user_data                   = "${var.Docker-install}"
  tags = {
    name = "public"
      }
}
module "website_s3_bucket" {
  source = "./modules"
bucket_name = "ookey2"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


