output "ec2_instance_public_id" {
  #value = aws_instance.my-ec2-terraform[*].public_ip
  value = [
    for ip in aws_instance.my-ec2-terraform : ip.public_ip
  ]
}

output "ec2_instance_public_dns" {
  #value = aws_instance.my-ec2-terraform[*].public_dns

  value = [
    for dns in aws_instance.my-ec2-terraform : dns.public_dns
  ]
}

output "ec2_instance_private_ip" {
  #value = aws_instance.my-ec2-terraform[*].private_ip

  value = [
    for private in aws_instance.my-ec2-terraform : private.private_ip
  ]
}