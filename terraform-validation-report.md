# Terraform Boilerplate Validation Report

**Total Violations Found: 29**

## Summary

| Category | Subcategory | Violation Count |
|----------|-------------|-----------------|
| Coding Standards | IncludeDescription | 2 |
| Improve Governance | EnforceResourceNaming | 13 |
| | RequireTags | 12 |
| | UseIAMRoles | 1 |
| Modular Design | LimitResourceCount | 1 |

## Detailed Findings

### Coding Standards

#### IncludeDescription

| File | Line | Message |
|------|------|---------|
| main.tf | 103 | Include a description for each resource |
| main.tf | 178 | Include a description for each resource |

### Improve Governance

#### EnforceResourceNaming

| File | Line | Message |
|------|------|---------|
| main.tf | 155 | Follow consistent resource naming conventions |
| main.tf | 156 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 11 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 17 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 23 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 29 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 35 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 41 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 47 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 53 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 59 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 65 | Follow consistent resource naming conventions |
| boilerplate_rules.tf | 71 | Follow consistent resource naming conventions |

#### RequireTags

| File | Line | Message |
|------|------|---------|
| main.tf | 10 | Include tags for better resource management |
| main.tf | 21 | Include tags for better resource management |
| main.tf | 31 | Include tags for better resource management |
| main.tf | 40 | Include tags for better resource management |
| main.tf | 50 | Include tags for better resource management |
| main.tf | 70 | Include tags for better resource management |
| main.tf | 84 | Include tags for better resource management |
| main.tf | 120 | Include tags for better resource management |
| main.tf | 135 | Include tags for better resource management |
| main.tf | 145 | Include tags for better resource management |
| main.tf | 164 | Include tags for better resource management |
| main.tf | 188 | Include tags for better resource management |

#### UseIAMRoles

| File | Line | Message |
|------|------|---------|
| boilerplate_rules.tf | 66 | Use IAM roles for access control instead of access keys |

### Modular Design

#### LimitResourceCount

| File | Line | Message |
|------|------|---------|
| main.tf | 58 | Consider using 'for_each' instead of 'count' for better modularity |


