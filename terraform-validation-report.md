# Terraform Boilerplate Validation Report

**Total Violations Found: 45**

## Summary

| Category | Subcategory | Violation Count |
|----------|-------------|-----------------|
| Accelerate Development and Operations | ImplementVariables | 1 |
| | UseCountOrForEach | 1 |
| | UseOutputs | 1 |
| Coding Standards | IncludeDescription | 2 |
| Facilitate Compliance | EnforceResourceTags | 12 |
| | UseCompliantAMIs | 1 |
| Improve Governance | EnforceResourceNaming | 13 |
| | RequireTags | 12 |
| | UseIAMRoles | 1 |
| Modular Design | LimitResourceCount | 1 |

## Detailed Findings

### Accelerate Development and Operations

#### ImplementVariables

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_rules.tf | 1 | Use variables to make your Terraform configurations more flexible and reusable | Correct: 'variable "environment" { type = string }' |

#### UseCountOrForEach

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 58 | Use count or for_each to manage similar resources efficiently | Correct: 'count = length(var.subnet_cidrs)' or 'for_each = toset(var.subnet_cidrs)' |

#### UseOutputs

| File | Line | Message | Example |
|------|------|---------|---------|
| output.tf | 1 | Define outputs to expose important information for other parts of your infrastructure | Correct: 'output "vpc_id" { value = aws_vpc.main.id }' |

### Coding Standards

#### IncludeDescription

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 103 | Include a description for each resource | Correct: 'description = "This is a description for the resource"'. |
| main.tf | 178 | Include a description for each resource | Correct: 'description = "This is a description for the resource"'. |

### Facilitate Compliance

#### EnforceResourceTags

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 10 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 21 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 31 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 40 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 50 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 70 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 84 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 120 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 135 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 145 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 164 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |
| main.tf | 188 | Ensure all resources have required tags for compliance and resource tracking | Correct: 'tags = { Environment = "prod", Project = "MyProject", Compliance = "PCI" }' |

#### UseCompliantAMIs

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 127 | Use only pre-approved, compliant AMIs for EC2 instances | Correct: 'ami = "ami-12345abcde"' where ami-12345abcde is a pre-approved AMI |

### Improve Governance

#### EnforceResourceNaming

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_rules.tf | 11 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 17 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 23 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 29 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 35 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 41 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 47 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 53 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 59 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 65 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| boilerplate_rules.tf | 71 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| main.tf | 155 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |
| main.tf | 156 | Follow consistent resource naming conventions | Correct: 'name = "resource-name"'. Incorrect: 'name = "ResourceName"'. |

#### RequireTags

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 10 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 21 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 31 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 40 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 50 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 70 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 84 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 120 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 135 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 145 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 164 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |
| main.tf | 188 | Include tags for better resource management | Correct: 'tags = { Environment = "prod" }'. |

#### UseIAMRoles

| File | Line | Message | Example |
|------|------|---------|---------|
| boilerplate_rules.tf | 66 | Use IAM roles for access control instead of access keys | Correct: 'iam_role = "role_name"' instead of storing access keys in code. |

### Modular Design

#### LimitResourceCount

| File | Line | Message | Example |
|------|------|---------|---------|
| main.tf | 58 | Consider using 'for_each' instead of 'count' for better modularity | Correct: 'for_each = var.resources'. |


