provider "aws" {
    region = "us-east-1"
}

variable "vpcname" {
    type = string
    default = "rede_vpc2"
}

variable "sshport" {
    type = number
    default = 22
}

variable "enabled" {
    default = true 
}

variable "mylist" {
    type = list(string)
    default = ["Value1","Value2"]
}

variable "mymap" {
    type = map
    default = {
        Key1 = "Value1"
        Key2 = "Value2"
    } 
}

resource "aws_vpc" "minha_rede_vpc" {
    cidr_block = "192.168.0.0/16"

    tags = {
      Name = var.inputname
    }
}

variable "inputname" {
    type = string
    description = "Please set the name of VPC"
}

output "vpcname" {
  value = aws_vpc.minha_rede_vpc.id
}

variable "mytuple" {
  
}