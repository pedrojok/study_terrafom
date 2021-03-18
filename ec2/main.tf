provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "teste-ec2" {
    ami = "ami-038f1ca1bd58a5790"
    instance_type = "t2.micro"
}