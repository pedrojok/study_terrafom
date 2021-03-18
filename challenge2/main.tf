provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "DB_Server" {
    ami = "ami-038f1ca1bd58a5790"
    instance_type = "t2.micro"
      tags = {
    Name = "DB_Server"
  }
}

resource "aws_instance" "WebServer" {
    ami = "ami-038f1ca1bd58a5790"
    instance_type = "t2.micro"
    key_name = "teste"
    security_groups = [aws_security_group.WebServer.name]

provisioner "file" {
   source     = "/home/pedro/Downloads/server-script.sh"
   destination = "/tmp/server-script.sh"
}

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/server-script.sh",
      "sudo /tmp/server-script.sh",
    ]
}

 connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = "${file("/home/pedro/Downloads/teste.pem")}"
    host        = self.public_ip
  }
    tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "WebServer" {
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
    description = "Allow HTTPS"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.128.26.208/32"]
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
    instance = aws_instance.WebServer.id
} 

output "Private_IP_DB_Server" {
    value = aws_instance.DB_Server.private_ip
}  

output "Public_IP_WebServer" {
    value = aws_instance.WebServer.public_ip
}

