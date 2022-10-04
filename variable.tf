variable "Vpc-CIDIR" {
  type = string
  default = "10.0.0.0/16"
}
variable "True-Value" {
  type = bool
  default = true
}
variable "type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}
variable "HTML-CODE" {
  type = string
  default = <<EOF
#!/bin/bash
  yum update -y
  yum install httpd -y
  service httpd start
  chkconfig httpd on
cd /var/www/html
echo 'Hello mathi, Welcome To My ec2-insatnce-1' > index.html
aws s3 mb s3://johnny-aws-guru-s3-bootstrap-01
aws s3 cp index.html s3://johnny-aws-guru-s3-bootstrap-01
EOF
}

variable "Docker-install" {
  type = string
  default = <<EOF
#!/bin/bash
sudo amazon-linux-extras install docker -y
sudo service docker star
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
mkdir mathi
  EOF
}
