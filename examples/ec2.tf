#Key pair login
resource "aws_key_pair" "my_keys" {
  key_name = "terraform-ec2-key"
  #instead of coping like this
  #public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0"
  public_key = file("terraform-ec2-key.pub")
}
#private vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

#security group 
resource "aws_security_group" "my_security" {
  name        = "my_sg"
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
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask app"
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
    name = "my_sg"
  }
}

#ec2 instance
resource "aws_instance" "my_ec2" {
  #count = 2 #meta arguements

  for_each = tomap({ #to install multiple instances
    "TWS_automate_micro" = "t2.micro"
    "TWS automate medium" = "t2.medium"
  })
  key_name        = aws_key_pair.my_keys.key_name
  security_groups = [aws_security_group.my_security.name]
  #instance_type   = var.aws_instance_type for single instance
  instance_type = each.value
  ami             = var.ec2_ami_id              #ubuntu
  user_data       = file("install_services.sh") #to install any service on creating ec2 instance

  root_block_device {                       # storage for instance
    #volume_size = var.aws_root_stroage_size #size o=in GB

    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size  //conditonal expression
    volume_type = "gp3"                     #general purpose 
  }

  


  tags = {
    #name = "first_ec2"
    name = each.key
  }
}