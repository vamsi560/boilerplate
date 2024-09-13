# Example Terraform file with random counts of violations for various rules

provider "aws" {
  region = "us-west-2"
}

# UseConsistentNaming: Violating the naming convention (should be snake_case)
resource "aws_instance" "MyInstance" { 
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  # IncludeDescription: Missing description
}

# EnforceResourceNaming: Correctly following the resource naming rule
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"

  tags = {
    Environment = "prod"
  }
}

# EnforceEncryption: Missing encryption in this resource
resource "aws_s3_bucket" "unencrypted_bucket" {
  bucket = "my-unencrypted-bucket"
  # Should have encrypted = true
}

# RequireTags: Missing tags for this resource (violating governance rules)
resource "aws_instance" "no_tags" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# UseIAMRoles: Missing IAM roles; using access keys (bad practice)
resource "aws_iam_access_key" "bad_access_key" {
  user = "my_user"
}

# EnforceEncryption: Missing encryption again for another resource
resource "aws_rds_instance" "unencrypted_rds" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  name              = "mydb"
  username          = "foo"
  password          = "bar"
  skip_final_snapshot = true

  # encrypted = false, should be true
}

# RestrictPublicAccess: Allowing public access (violation of security rule)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id
  public_access_block_configuration {
    block_public_acls = false  # Should be true
  }
}

# Correct usage of data source (following best practices)
data "aws_ami" "example" {
  most_recent = true
  owners      = ["self"]
}

# UseSecureProtocols: Violating the HTTPS requirement
resource "aws_security_group" "insecure_sg" {
  protocol = "http"
}

# Correctly using modules for VPC (following modular design)
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.0"
  cidr = "10.0.0.0/16"
}

# Missing module for EC2 instances (violating modular design rule)
resource "aws_instance" "instance_no_module" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# Long-running process flag is set (should be avoided)
resource "aws_instance" "long_process" {
  ami                 = "ami-0c55b159cbfafe1f0"
  instance_type       = "t2.micro"
  long_running_process = true  # Violation
}

# Correct use of variables for flexibility (following best practices)
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

resource "aws_instance" "good_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}

# Correct use of outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

# UseCountOrForEach: Good use of for_each for managing resources
resource "aws_subnet" "my_subnets" {
  for_each = toset(["subnet1", "subnet2", "subnet3"])
  vpc_id   = module.vpc.vpc_id
  cidr_block = cidrsubnet(module.vpc.cidr_block, 8, count.index)
}

# UseRemoteBackend: Missing remote backend configuration (should use remote)
terraform {
  backend "local" {}  # Should use remote backend like S3
}

# EnableLogging: Logging disabled (should be enabled for compliance)
resource "aws_s3_bucket" "bucket_no_logging" {
  bucket = "my-logging-bucket"
  logging {
    target_bucket = "my-log-bucket"
    target_prefix = "log/"
  }
}

# Optimized Database Queries: Avoiding SELECT * query (following performance optimization)
resource "aws_rds_instance" "optimized_db" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  name              = "mydb"
  username          = "foo"
  password          = "bar"
}

# Correct usage of a compliant AMI
resource "aws_instance" "compliant_instance" {
  ami           = "ami-1234567890abcdef0"  # Pre-approved AMI
  instance_type = "t2.micro"
}

# UseComments: Missing comments (should add comments to explain logic)
resource "aws_instance" "no_comments" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
