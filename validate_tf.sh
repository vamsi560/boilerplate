#!/bin/bash

# Directory to validate
TF_DIR="./"

# Create or clear the validation results file
RESULTS_FILE="validation_results.txt"
> $RESULTS_FILE

# Function to validate .tf files
validate_tf_files() {
    for tf_file in $(find $TF_DIR -name "*.tf"); do
        echo "Validating $tf_file..."

        # Read file line by line
        while IFS= read -r line; do
            # Check for missing variable descriptions
            if [[ $line =~ ^\s*variable\s+"[^"]+"\s*{ ]]; then
                # Look ahead in the file for description
                if ! grep -A 5 -F "$line" "$tf_file" | grep -q "description"; then
                    echo "Variable should have a description in $tf_file" >> $RESULTS_FILE
                fi
            fi

            # Check for hardcoded values
            if [[ $line =~ [\"\'(.*?)\"\' ] && ! [[ $line =~ \${{ ]]; then
                echo "Avoid hardcoding values in $tf_file" >> $RESULTS_FILE
            fi

            # Check for missing output descriptions
            if [[ $line =~ ^\s*output\s+"[^"]+"\s*{ ]]; then
                # Look ahead in the file for description
                if ! grep -A 5 -F "$line" "$tf_file" | grep -q "description"; then
                    echo "Output should have a description in $tf_file" >> $RESULTS_FILE
                fi
            fi
        done < "$tf_file"
    done
}

# Run validation
validate_tf_files

# Check if validation failed
if [ -s $RESULTS_FILE ]; then
    echo "Validation failed. See $RESULTS_FILE for details."
    cat $RESULTS_FILE
    exit 1
else
    echo "Validation succeeded."
fi
