provider "aws" {
  region     = "us-east-2"
  access_key = "AKIASZTTQPYFFCN7IVPS"
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
resource "aws_security_group" "my-sec-gp" {
  name   = "new-sec-gp"
  vpc_id = aws_vpc.private-sub-testing.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
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
123464846464464464464646446446446464