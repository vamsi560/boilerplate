provider "aws" {
  region = "us-west-2"  # Specify your desired region
}

variable "example_variable" {
  type = string
  # Missing description
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "hardcoded-bucket-name"  # Hardcoded value
  acl    = "private"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
  # Missing description
}
