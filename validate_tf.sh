#!/bin/bash

# Directory containing .tf files
TF_DIR="./"

# Run Python validation script
python3 validate_tf.py $TF_DIR

# Capture the exit code of the Python script
if [ $? -ne 0 ]; then
  echo "Validation failed."
  exit 1
fi

# Create or clear the validation results file
RESULTS_FILE="validation_results.txt"
> $RESULTS_FILE

# Copy validation results to a file
# This assumes the Python script prints results to stdout
python3 validate_tf.py $TF_DIR > $RESULTS_FILE

# Print results for review
echo "Validation results:"
cat $RESULTS_FILE

# Commit and push results if required
git config --global user.email "vamsi.sapireddy@outlook.com"
git config --global user.name "vamsi560"

git pull
git add validation_results.txt
git commit -m "Add validation results"
git push
