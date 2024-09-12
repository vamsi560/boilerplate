provider "aws" {
  # This provider block is missing required parameters like region
  # violations: Missing required parameters
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"
  # Violations: Hardcoded bucket name which should be parameterized
}

resource "aws_instance" "example" {
  ami           = "ami-12345678" # Violations: Hardcoded AMI ID should be parameterized
  instance_type = "t2.micro"
  
  tags = {
    Name = "example-instance" # Violations: Tags should follow naming conventions
  }

  # Violations: Missing proper security group configuration
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "instance_id" {
  value = aws_instance.example.id
}
