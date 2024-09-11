import os
import re
import sys

def validate_tf_files(directory):
    corrections = {}
    
    for filename in os.listdir(directory):
        if filename.endswith(".tf"):
            file_path = os.path.join(directory, filename)
            
            with open(file_path, 'r') as file:
                lines = file.readlines()
            
            # Print debug information
            print(f"Processing file: {filename}")
            
            for i, line in enumerate(lines):
                # Debug: Print each line and its index
                print(f"Line {i + 1}: {line.strip()}")
                
                # Check for missing variable descriptions
                if re.match(r'^\s*variable\s+"[^"]+"\s*{', line):
                    block = lines[i:i+5]
                    if not any("description" in l for l in block):
                        corrections.setdefault(filename, []).append(f"Line {i + 1}: Variable should have a description.")
                        lines[i] = line.rstrip() + ' # Missing description\n'
                        # Debug: Print correction
                        print(f"Correction added for variable at line {i + 1}")
                
                # Check for missing output descriptions
                if re.match(r'^\s*output\s+"[^"]+"\s*{', line):
                    block = lines[i:i+5]
                    if not any("description" in l for l in block):
                        corrections.setdefault(filename, []).append(f"Line {i + 1}: Output should have a description.")
                        lines[i] = line.rstrip() + ' # Missing description\n'
                        # Debug: Print correction
                        print(f"Correction added for output at line {i + 1}")
            
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
