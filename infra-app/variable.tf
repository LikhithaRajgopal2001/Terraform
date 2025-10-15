variable "env" {
  description = "This is the env for infra"
  type = string
}

variable "bucket_name" {
description = "This is the bucket name for infra"
  type = string
}

variable "instance_count" {
  description = "No of instances for infra"
  type = number
}

variable "instance_type" {
  description = "type instances for infra"
  type = string
}

variable "ec2_ami_id" {
  description = "ami id of instances for infra"
  type = string
}
variable "hash_key" {
  description = "hash key of the dynamo db"
  type = string
}