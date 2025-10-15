terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }

  backend "s3" {
  bucket = "my-s3-bucket"
  key = "terraform.tfstate"
  region = "us-east-2"
  dynamodb_table = "my-dynamo"
}
}
