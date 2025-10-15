resource "aws_key_pair" "my_ec2_terraform_keys" {
  key_name   = "terraform-ec2-key"
  public_key = file("terraform-ec2-key.pub")
}


resource "aws_default_vpc" "default_vpc" {
  tags = {
    name = "default_vpc_1"
  }
}


resource "aws_security_group" "my_new_security_group" {

  name        = "my_new_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH port allowed"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP is open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access"
  }

  tags = {
    name = "my-sg-terraform-test"

  }

}

resource "aws_instance" "my-ec2-terraform" {
#count = 2

for_each = tomap({
    "likitha_t2_micor" = "t3.micro"
    "likitha_t3_medium" = "t3.micro"
})
  key_name        = aws_key_pair.my_ec2_terraform_keys.key_name
  security_groups = [aws_security_group.my_new_security_group.name]

  #instance_type = var.my-intance-type
  instance_type = each.value
  ami           = var.my_ec2_ami

  user_data = file("nginx.sh")
  root_block_device {
    #volume_size = var.My_stoage
    volume_size = var.env == "prod" ? 20 : var.My_stoage
    volume_type = "gp3"

  }

  tags = {
    #name = var.my_ec2_instance_name
    name = each.key
  }
}