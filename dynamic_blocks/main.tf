provider "aws" {
    region = "us-east-1"
}

variable "ingressrules" {
    type = list(number)
    default = [80,443,8]
  
}

variable "egressrules" {
    type = list(number)
    default = [80,443,3306,53,110]
}

resource "aws_instance" "web_ec2" {
    ami = "ami-038f1ca1bd58a5790"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.SG_Teste.name]
}

resource "aws_security_group" "SG_Teste" {
    name = "Allow SG_Teste"

  dynamic "ingress" {
    iterator   = port
    for_each    =  var.ingressrules
    content {
    description = "Allow SG_Teste_Ingress"
    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator   = port
    for_each    =  var.egressrules
    content {
    description = "Allow SG_Teste_Engress"
    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "Allow SG_Teste"
  }
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.web_ec2.id
  }

output "EIP" {
    value = aws_eip.elasticip.public_ip
}