resource "aws_s3_bucket" "my_infra-app" {
  bucket = "${var.env}-${var.bucket_name}"


tags = {
    Name = "${var.env}-${var.bucket_name}"
    environment = var.env
}
}