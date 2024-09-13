# Terraform Boilerplate Validation Report

**Total Violations Found: 54**

## Summary

| Category | Subcategory | Violation Count |
|----------|-------------|-----------------|
| Accelerate Development and Operations | ImplementVariables | 1 |
| | UseCountOrForEach | 2 |
| | UseOutputs | 2 |
| | UseRemoteBackend | 1 |
| Coding Standards | IncludeDescription | 2 |
| | UseDataSources | 1 |
| Ensure Security | EnforceEncryption | 1 |
| Facilitate Compliance | EnforceResourceTags | 13 |
| | UseCompliantAMIs | 8 |
| Improve Governance | EnforceResourceNaming | 6 |
| | RequireTags | 13 |
| Modular Design | LimitResourceCount | 1 |
| | UseModules | 1 |
| Performance Optimization | AvoidLongRunningProcesses | 1 |
| | OptimizeDatabaseQueries | 1 |

## Detailed Findings

### Accelerate Development and Operations

#### ImplementVariables

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 93 | Use variables to make your Terraform configurations more flexible and reusable |  'variable "environment" { type = string }' |

#### UseCountOrForEach

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 58 | Use count or for_each to manage similar resources efficiently |  'count = length(var.subnet_cidrs)' or 'for_each = toset(var.subnet_cidrs)' |
| boilerplate_sample.tf | 110 | Use count or for_each to manage similar resources efficiently |  'count = length(var.subnet_cidrs)' or 'for_each = toset(var.subnet_cidrs)' |

#### UseOutputs

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 104 | Define outputs to expose important information for other parts of your infrastructure |  'output "vpc_id" { value = aws_vpc.main.id }' |
| output.tf | 1 | Define outputs to expose important information for other parts of your infrastructure |  'output "vpc_id" { value = aws_vpc.main.id }' |

#### UseRemoteBackend

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 117 | Configure a remote backend for state management and collaboration |  'backend "s3" { bucket = "my-terraform-state" ... }' |

### Coding Standards

#### IncludeDescription

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 103 | Include a description for each resource |  'description = "This is a description for the resource"'. |
| main.tf | 178 | Include a description for each resource |  'description = "This is a description for the resource"'. |

#### UseDataSources

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 62 | Use data sources where appropriate instead of hardcoding values |  'data "aws_ami" "example" {...}' instead of hardcoded AMI IDs. |

### Ensure Security

#### EnforceEncryption

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 26 | Ensure resources are encrypted where applicable |  'encrypted = true' for S3 buckets, RDS instances, etc. |

### Facilitate Compliance

#### EnforceResourceTags

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 10 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 21 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 31 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 40 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 50 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 70 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 84 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 120 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 135 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 145 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 164 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 188 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| boilerplate_sample.tf | 18 | Ensure all resources have required tags for compliance and resource tracking |  'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |

#### UseCompliantAMIs

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 127 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 9 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 31 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 81 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 87 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 99 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 141 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |
| boilerplate_sample.tf | 147 | Use only pre-approved, compliant AMIs for EC2 instances |  'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |

### Improve Governance

#### EnforceResourceNaming

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 155 | Follow consistent resource naming conventions |  'name = "resource-name"'. In 'name = "ResourceName"'. |
| main.tf | 156 | Follow consistent resource naming conventions |  'name = "resource-name"'. In 'name = "ResourceName"'. |
| boilerplate_sample.tf | 45 | Follow consistent resource naming conventions |  'name = "resource-name"'. In 'name = "ResourceName"'. |
| boilerplate_sample.tf | 46 | Follow consistent resource naming conventions |  'name = "resource-name"'. In 'name = "ResourceName"'. |
| boilerplate_sample.tf | 134 | Follow consistent resource naming conventions |  'name = "resource-name"'. In 'name = "ResourceName"'. |
| boilerplate_sample.tf | 135 | Follow consistent resource naming conventions |  'name = "resource-name"'. In 'name = "ResourceName"'. |

#### RequireTags

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 10 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 21 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 31 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 40 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 50 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 70 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 84 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 120 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 135 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 145 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 164 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| main.tf | 188 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |
| boilerplate_sample.tf | 18 | Include tags for better resource management |  'tags = { Environment = "prod" }'. |

### Modular Design

#### LimitResourceCount

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 58 | Consider using 'for_each' instead of 'count' for better modularity |  'for_each = var.resources'. |

#### UseModules

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 73 | Use modules to organize and reuse code |  'module "vpc" { source = "terraform-aws-modules/vpc/aws" ... }'. |

### Performance Optimization

#### AvoidLongRunningProcesses

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 89 | Avoid long-running processes; consider using asynchronous operations | Avoid: 'long_running_process = true' where async tasks can be used. |

#### OptimizeDatabaseQueries

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_sample.tf | 129 | Avoid using SELECT *; specify columns to optimize database queries |  'SELECT id, name FROM users' instead of 'SELECT * FROM users'. |


