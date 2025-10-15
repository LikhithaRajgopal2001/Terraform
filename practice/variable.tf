variable "my_ec2_ami" {
  default = "ami-00e73adb2e2c80366"
  type    = string
}

variable "My_stoage" {
  default = 10
  type    = number
}

variable "my_ec2_instance_name" {
  default = "my_ec2"
  type    = string
}

variable "my-intance-type" {
  default = "t3.micro"
  type    = string
}

variable "env" {
  default = "prod"
  type = string
}