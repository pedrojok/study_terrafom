provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "minha_rede_vpc" {
    cidr_block = "192.168.0.0/16"
  
}