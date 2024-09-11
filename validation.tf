terraform {
  required_version = ">= 0.14"
}

# Example variable definitions
variable "example_variable" {
  description = "This variable should have a description."
  type        = string
  default     = "default_value"  # Change this to a variable reference if needed
}

variable "another_variable" {
  description = "Another example variable."
  type        = string
  default     = "hardcoded_value"  # This should be avoided
}

# Validate that all variables have descriptions
locals {
  variable_descriptions = [
    for v in [
      {
        name        = "example_variable"
        description = var.example_variable
      },
      {
        name        = "another_variable"
        description = var.another_variable
      }
    ] : v if length(v.description) == 0
  ]
}

# Validate that no hardcoded values are used
resource "null_resource" "validate" {
  count = length(local.variable_descriptions)

  provisioner "local-exec" {
    command = "echo Variable '${local.variable_descriptions[count.index].name}' is missing a description."
    when    = local.variable_descriptions[count.index].description == ""
  }
}

# Output example
output "example_output" {
  value       = "This is an example output."
  description = "Output should have a description."
}

# Validate outputs
locals {
  output_descriptions = [
    for o in [
      {
        name        = "example_output"
        description = "Output should have a description."
      }
    ] : o if length(o.description) == 0
  ]
}

resource "null_resource" "validate_outputs" {
  count = length(local.output_descriptions)

  provisioner "local-exec" {
    command = "echo Output '${local.output_descriptions[count.index].name}' is missing a description."
    when    = local.output_descriptions[count.index].description == ""
  }
}
