# VIOLATION: ValidLocation - Resource location should be one of: eastus, westus, or centralus.
# VIOLATION: ValidSize - Resource size should be one of: Standard_DS1_v2 or Standard_DS2_v2.
# VIOLATION: ValidResourceGroup - Resource group name must follow alphanumeric, underscore, or hyphen conventions.
# VIOLATION: ValidIPRange - Firewall IP range must be a valid CIDR range.
Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Main VPC"
  }
}

# Create public and private subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Private Subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Main IGW"
  }
}

# Create a NAT Gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Main NAT Gateway"
  }
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  vpc   = true
# VIOLATION: LimitResourceCount - Consider using 'for_each' instead of 'count' for better modularity
# VIOLATION: UseCountOrForEach - Use count or for_each to manage similar resources efficiently
  count = 1
}

# Create a Route Table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Public Route Table"
  }
}

# Create a Route Table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Private Route Table"
  }
}

# Associate subnets with route tables
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Create a Security Group for EC2 instances
resource "aws_security_group" "allow_ssh" {
  name        = "Allow SSH"
# VIOLATION: IncludeDescription - Include a description for each resource
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Allow SSH Security Group"
  }
}

# Create an EC2 instance
resource "aws_instance" "example" {
# VIOLATION: UseCompliantAMIs - Use only pre-approved, compliant AMIs for EC2 instances
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Example Instance"
  }
}

# Create an S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"
  acl    = "private"

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Example S3 Bucket"
  }
}

# Create an RDS instance
resource "aws_db_instance" "example" {
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
# VIOLATION: EnforceResourceNaming - Follow consistent resource naming conventions
  name           = "exampledb"
# VIOLATION: EnforceResourceNaming - Follow consistent resource naming conventions
  username       = "admin"
  password       = "password123"
  db_subnet_group_name = aws_db_subnet_group.private.name

  vpc_security_group_ids = [
    aws_security_group.allow_db.id
  ]

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Example RDS Instance"
  }
}

# Create a DB subnet group for the RDS instance
resource "aws_db_subnet_group" "private" {
  name       = "Private DB Subnet Group"
  subnet_ids = [aws_subnet.private.id]
}

# Create a Security Group for the RDS instance
resource "aws_security_group" "allow_db" {
  name        = "Allow DB"
# VIOLATION: IncludeDescription - Include a description for each resource
  description = "Allow DB inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_ssh.id]
  }

# VIOLATION: RequireTags - Include tags for better resource management
# VIOLATION: EnforceResourceTags - Ensure all resources have required tags for compliance and resource tracking
  tags = {
    Name = "Allow DB Security Group"
  }
}
