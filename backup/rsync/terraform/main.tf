provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg_rsync" {
  name        = "sg_rsync"
  description = "Grupo de seguridad para pruebas de RSYNC"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 873
    to_port     = 873
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prueba_rsync" {
  ami             = var.instance_ami
  instance_type   = var.ram_instance
  security_groups = [aws_security_group.sg_rsync.name]
  key_name        = var.key_file_name
  user_data       = file("directorio.sh")

  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "ip_elastica_rsync" {
  instance = aws_instance.prueba_rsync.id
}

output "rsync_eip" {
  value = aws_eip.ip_elastica_rsync.public_ip
}
