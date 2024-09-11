import os
import re
import sys

def validate_tf_files(directory):
    corrections = {}
    
    # Iterate over all .tf files in the directory
    for filename in os.listdir(directory):
        if filename.endswith(".tf"):
            file_path = os.path.join(directory, filename)
            
            with open(file_path, 'r') as file:
                lines = file.readlines()
            
            # Check for issues in the file
            for i, line in enumerate(lines):
                # Check for missing variable descriptions
                if re.match(r'^\s*variable\s+"[^"]+"\s*{', line):
                    # Check if variable has a description
                    block = lines[i:i+5]  # Read next 5 lines to check for description
                    if not any("description" in l for l in block):
                        corrections.setdefault(filename, []).append(f"Line {i + 1}: Variable should have a description.")
                        lines[i] = line.rstrip() + ' # Missing description\n'  # Add comment

                # Check for hardcoded values
                if re.search(r'["\'](.*?)["\']', line) and not re.search(r'\${{', line):
                    corrections.setdefault(filename, []).append(f"Line {i + 1}: Avoid hardcoding values. Use variables instead.")
                    lines[i] = line.rstrip() + ' # Consider using a variable\n'  # Add comment

                # Check for missing output descriptions
                if re.match(r'^\s*output\s+"[^"]+"\s*{', line):
                    # Check if output has a description
                    block = lines[i:i+5]  # Read next 5 lines to check for description
                    if not any("description" in l for l in block):
                        corrections.setdefault(filename, []).append(f"Line {i + 1}: Output should have a description.")
                        lines[i] = line.rstrip() + ' # Missing description\n'  # Add comment
            
            # Write the updated lines back to the file
            with open(file_path, 'w') as file:
                file.writelines(lines)
    
    return corrections

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 validate_tf.py <directory>")
        sys.exit(1)
    
    directory = sys.argv[1]
    corrections = validate_tf_files(directory)
    
    if corrections:
        for file, messages in corrections.items():
            print(f"Corrections for {file}:")
            for message in messages:
                print(message)
    else:
        print("No corrections needed.")
