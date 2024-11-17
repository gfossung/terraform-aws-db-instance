terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 5.0"
      }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

/*resource "aws_vpc" "ecommerce-vpc" {
  cidr_block = "10.10.0.0/16"
}
*/
/*resource "aws_security_group" "aws_default_sg" {
  description = "default VPC security group"
  ingress {
    description      = "HTTP from ALL Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
*/
resource "aws_security_group" "dbserversg" {
  name        = "dbserversg"
  description = "DBServer Security Group"
  #vpc_id      = aws_vpc.ecommerce-vpc.id

  ingress {
    description      = "HTTP from all over the world"
    from_port        = "${var.dbport}"
    to_port          = "${var.dbport}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}


resource "aws_ebs_volume" "dbservervolume" {
  availability_zone = "${var.az}"
  size              = "${var.dbsize}"
  tags = {
    Name = "dbservervolume"
  }
}

resource "aws_instance" "dbserver" {
  availability_zone = "${var.az}"
  ami           = "${var.ami}"
  instance_type = "${var.typeofinstance}"
  key_name      = "${var.keyname}"
  vpc_security_group_ids = [ aws_security_group.dbserversg.id ]
  tags = {
    Name = "dbservervolume"
  }
}

resource "aws_volume_attachment" "dbservervolumeattach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.dbservervolume.id
  instance_id = aws_instance.dbserver.id
}

