provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web_ec2" {
    ami = "ami-038f1ca1bd58a5790"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.SG_Web.name]
}

resource "aws_security_group" "SG_Web" {
    name = "Allow HTTP/HTTPS"

  ingress {
    description = "Allow HTTPS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "Allow ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP/HTTPS"
  }
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.web_ec2.id
  }

output "EIP" {
    value = aws_eip.elasticip.public_ip
}