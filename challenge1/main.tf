provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "TerraformVPC" {
    cidr_block = "192.168.0.0/24"
    enable_dns_hostnames = "true"
    enable_classiclink_dns_support = "true"
    enable_classiclink = "false"

    tags = {
      "Name" = "TerraformVPC"
    }
}