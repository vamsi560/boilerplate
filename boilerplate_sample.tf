# VIOLATION: ValidLocation - Resource location should be one of: eastus, westus, or centralus.
# VIOLATION: ValidSize - Resource size should be one of: Standard_DS1_v2 or Standard_DS2_v2.
# VIOLATION: ValidResourceGroup - Resource group name must follow alphanumeric, underscore, or hyphen conventions.
# VIOLATION: ValidIPRange - Firewall IP range must be a valid CIDR range.
# Example Terraform file with random counts of violations for various rules

provider "aws" {
  region = "us-west-2"
}

# UseConsistentNaming: Violating the naming convention (should be snake_case)
resource "aws_instance" "MyInstance" { 
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  # IncludeDescription: Missing description
}

# EnforceResourceNaming: Correctly following the resource naming rule
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Environment = "prod"
  }
}

# EnforceEncryption: Missing encryption in this resource
resource "aws_s3_bucket" "unencrypted_bucket" {
  bucket = "my-unencrypted-bucket"
# VIOLATION: EnforceEncryption - Ensure resources are encrypted where applicable
  # Should have encrypted = true
}

# RequireTags: Missing tags for this resource (violating governance rules)
resource "aws_instance" "no_tags" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
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
# VIOLATION: EnforceResourceNaming - Follow consistent resource naming conventions
  name              = "mydb"
# VIOLATION: EnforceResourceNaming - Follow consistent resource naming conventions
  username          = "foo"
  password          = "bar"
  skip_final_snapshot = true

  # encrypted = false, should be true
}

# RestrictPublicAccess: Allowing public access (violation of security rule)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id
  public_access_block_configuration {
  }
}

# Correct usage of data source (following best practices)
# VIOLATION: UseDataSources - Use data sources where appropriate instead of hardcoding values
data "aws_ami" "example" {
  most_recent = true
  owners      = ["self"]
}

# UseSecureProtocols: Violating the HTTPS requirement
resource "aws_security_group" "insecure_sg" {
  protocol = "http"
}

# Correctly using modules for VPC (following modular design)
# VIOLATION: UseModules - Use modules to organize and reuse code
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.0"
  cidr = "10.0.0.0/16"
}

# Missing module for EC2 instances (violating modular design rule)
resource "aws_instance" "instance_no_module" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# Long-running process flag is set (should be avoided)
resource "aws_instance" "long_process" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami                 = "ami-0c55b159cbfafe1f0"
  instance_type       = "t2.micro"
# VIOLATION: AvoidLongRunningProcesses - Avoid long-running processes; consider using asynchronous operations
  long_running_process = true  # Violation
}

# Correct use of variables for flexibility (following best practices)
# VIOLATION: ImplementVariables - Use variables to make your Terraform configurations more flexible and reusable
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

resource "aws_instance" "good_instance" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}

# Correct use of outputs
# VIOLATION: UseOutputs - Define outputs to expose important information for other parts of your infrastructure
output "vpc_id" {
  value = module.vpc.vpc_id
}

# UseCountOrForEach: Good use of for_each for managing resources
resource "aws_subnet" "my_subnets" {
# VIOLATION: UseCountOrForEach - Use count or for_each to manage similar resources efficiently
  for_each = toset(["subnet1", "subnet2", "subnet3"])
  vpc_id   = module.vpc.vpc_id
  cidr_block = cidrsubnet(module.vpc.cidr_block, 8, count.index)
}

# UseRemoteBackend: Missing remote backend configuration (should use remote)
terraform {
# VIOLATION: UseRemoteBackend - Configure a remote backend for state management and collaboration
# VIOLATION: SearchBackend - Searches for 'backend' configuration blocks in Terraform code
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

# VIOLATION: OptimizeDatabaseQueries - Avoid using SELECT *; specify columns to optimize database queries
# Optimized Database Queries: Avoiding SELECT * query (following performance optimization)
resource "aws_rds_instance" "optimized_db" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t2.micro"
# VIOLATION: EnforceResourceNaming - Follow consistent resource naming conventions
  name              = "mydb"
# VIOLATION: EnforceResourceNaming - Follow consistent resource naming conventions
  username          = "foo"
  password          = "bar"
}

# Correct usage of a compliant AMI
resource "aws_instance" "compliant_instance" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami           = "ami-1234567890abcdef0"  # Pre-approved AMI
  instance_type = "t2.micro"
}

# UseComments: Missing comments (should add comments to explain logic)
resource "aws_instance" "no_comments" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
