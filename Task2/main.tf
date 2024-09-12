resource "aws_instance" "vikash-ec2" {

  ami                    = var.ami
  instance_type          = var.instance_type
  tags                   = var.tag_name
}