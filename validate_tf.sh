#!/bin/bash

# Find all .tf files
for file in $(find . -name "*.tf"); do
    echo "Validating $file"
    
    # Run Terraform validate command
    output=$(terraform validate $file 2>&1)
    
    if [[ $? -ne 0 ]]; then
        # Add validation errors as comments at the top of the file
        echo -e "# Validation suggestion:\n# $output\n$(cat $file)" > $file
    else
        echo "$file is valid."
    fi
done
