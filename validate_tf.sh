#!/bin/bash

# Create or clear the validation results file
> validation_results.txt

# Find all .tf files
for file in $(find . -name "*.tf"); do
    echo "Validating $file" >> validation_results.txt
    
    # Run Terraform validate command
    output=$(terraform validate $file 2>&1)
    
    if [[ $? -ne 0 ]]; then
        # Add validation errors as comments at the top of the file
        echo -e "# Validation suggestion:\n# $output\n$(cat $file)" > $file
        
        # Append the results to the validation results file
        echo "$file:" >> validation_results.txt
        echo "$output" >> validation_results.txt
        echo "" >> validation_results.txt
    else
        echo "$file is valid." >> validation_results.txt
    fi
done
