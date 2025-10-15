resource "aws_s3_bucket" "remote-s3" {
  bucket = "my-s3-bucket"
  tags = {
    Name        = "my-s3-bucket"
    #Environment = "Dev"
  }
}
