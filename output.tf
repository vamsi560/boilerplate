# VIOLATION: ValidLocation - Resource location should be one of: eastus, westus, or centralus.
# VIOLATION: ValidSize - Resource size should be one of: Standard_DS1_v2 or Standard_DS2_v2.
# VIOLATION: ValidResourceGroup - Resource group name must follow alphanumeric, underscore, or hyphen conventions.
# VIOLATION: ValidIPRange - Firewall IP range must be a valid CIDR range.
# VIOLATION: UseOutputs - Define outputs to expose important information for other parts of your infrastructure
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
  # Missing description
}
