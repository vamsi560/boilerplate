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
            
            corrected_lines = []
            i = 0
            while i < len(lines):
                line = lines[i]
                
                # Check for missing variable descriptions
                if re.match(r'^\s*variable\s+"[^"]+"\s*{', line):
                    block = lines[i:i+5]
                    if not any("description" in l for l in block):
                        corrections.setdefault(filename, []).append(f"Line {i + 1}: Variable should have a description.")
                        corrected_lines.append(line.rstrip() + ' # Missing description\n')
                    else:
                        corrected_lines.append(line)
                    i += 5  # Skip ahead after processing a block
                # Check for missing output descriptions
                elif re.match(r'^\s*output\s+"[^"]+"\s*{', line):
                    block = lines[i:i+5]
                    if not any("description" in l for l in block):
                        corrections.setdefault(filename, []).append(f"Line {i + 1}: Output should have a description.")
                        corrected_lines.append(line.rstrip() + ' # Missing description\n')
                    else:
                        corrected_lines.append(line)
                    i += 5  # Skip ahead after processing a block
                else:
                    corrected_lines.append(line)
                i += 1
            
            # Write back the corrected lines
            with open(file_path, 'w') as file:
                file.writelines(corrected_lines)
    
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
