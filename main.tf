variable "my_var" {
    type = string  # Missing description
}

output "my_output" {
    value = var.my_var  # Missing description
}
