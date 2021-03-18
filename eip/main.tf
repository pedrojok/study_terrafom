provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web_ec2" {
    ami = "ami-038f1ca1bd58a5790"
    instance_type = "t2.micro"
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.web_ec2.id
  }

output "EIP" {
    value = aws_eip.elasticip.public_ip
}