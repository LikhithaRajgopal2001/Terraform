resource "aws_dynamodb_table" "remote-dynamo" {
  name           = "my-dynamo"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

 
  tags = {
    Name        = "my-dynamo"
    #Environment = "production"
  }
}
