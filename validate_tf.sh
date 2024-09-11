#!/bin/bash

# Directory to validate
TF_DIR="./"

# Create or clear the validation results file
RESULTS_FILE="validation_results.txt"
> $RESULTS_FILE

# Find all .tf files and validate them
find $TF_DIR -name "*.tf" | while read tf_file; do
  echo "Validating $tf_file..."
  terraform validate -no-color $tf_file >> $RESULTS_FILE 2>&1
done

# Check if validation failed
if grep -q "Error:" $RESULTS_FILE; then
  echo "Validation failed. See $RESULTS_FILE for details."
  cat $RESULTS_FILE  # Print results to logs for easier debugging
  exit 1
else
  echo "Validation succeeded."
fi
