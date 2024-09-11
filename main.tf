provider "aws" {
  region = "us-west-2"  # Specify your desired region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # Replace with your unique bucket name
  acl    = "private"  # Set the access control list

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}
