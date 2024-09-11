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
            # Get line number
            line_num=$(grep -n -F "$line" "$tf_file" | cut -d: -f1)

            # Check for missing variable descriptions
            if [[ $line =~ ^\s*variable\s+"[^"]+"\s*{ ]]; then
                if ! grep -A 5 -F "$line" "$tf_file" | grep -q "description"; then
                    echo "Line $line_num: Variable should have a description." >> $RESULTS_FILE
                    sed -i "${line_num}s/.*/& # Missing description/" "$tf_file"
                fi
            fi

            # Check for hardcoded values
            if [[ $line =~ ["'](.*?)["'] ]] && ! [[ $line =~ \${{ ]]; then
                echo "Line $line_num: Avoid hardcoding values. Use variables instead." >> $RESULTS_FILE
                sed -i "${line_num}s/.*/& # Consider using a variable/" "$tf_file"
            fi

            # Check for missing output descriptions
            if [[ $line =~ ^\s*output\s+"[^"]+"\s*{ ]]; then
                if ! grep -A 5 -F "$line" "$tf_file" | grep -q "description"; then
                    echo "Line $line_num: Output should have a description." >> $RESULTS_FILE
                    sed -i "${line_num}s/.*/& # Missing description/" "$tf_file"
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
