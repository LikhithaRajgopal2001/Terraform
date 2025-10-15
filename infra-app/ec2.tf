#Key pair login
resource "aws_key_pair" "my_keys" {
  key_name = "${var.env}-infra-app"
  #instead of coping like this
  #public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0"
  public_key = file("terraform-ec2-key.pub")

  tags = {
    environment = var.env
  }
}
#private vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

#security group 
resource "aws_security_group" "my_security" {
  name        = "${var.env}-infra-app-sg"
  description = "This is auto sg creation"
  vpc_id      = aws_default_vpc.default.id # interpolation
  #inbound rules  as also mentioned as ingress
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP is open"
  }
  

  #outbound rules as also mentioned as egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allowing all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access"
  }

  tags = {
    name = "${var.env}-infra-app-sg"
  }
}

#ec2 instance
resource "aws_instance" "my_ec2" {
count = var.instance_count  
  key_name        = aws_key_pair.my_keys.key_name
  security_groups = [aws_security_group.my_security.name]
  #instance_type   = var.aws_instance_type for single instance
  instance_type = var.instance_type
  ami             = var.ec2_ami_id              #ubuntu
  
  root_block_device {                       # storage for instance
    #volume_size = var.aws_root_stroage_size #size o=in GB

    volume_size = var.env == "prod" ? 20 : 10  //conditonal expression
    volume_type = "gp3"                     #general purpose 
  }

  

  tags = {
    #name = "first_ec2"
    name = "${var.env}-ec2-instance"
    environment = var.env
  }
}