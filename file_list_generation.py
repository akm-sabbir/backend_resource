import os

def generate_subdirectory_indexes(target_directory):
    """
    Recursively walks through a target directory, collects all file names 
    within each subdirectory, and writes them into a local text file.
    """
    # Name of the output file to create in each directory
    index_file_name = "files_list.txt"
    
    print(f"Starting directory scan inside: {os.path.abspath(target_directory)}\n")
    
    # os.walk automatically crawls through all nested folders recursively
    for root, dirs, files in os.walk(target_directory):
        
        # Filter out the index file itself if running the script multiple times
        valid_files = [f for f in files if f != index_file_name]
        
        # Only create a text file if the subdirectory actually contains files
        if valid_files:
            output_file_path = os.path.join(root, index_file_name)
            
            try:
                # Open/create the text file using utf-8 encoding for safety
                with open(output_file_path, "w", encoding="utf-8") as txt_file:
                    # Sort alphabetically for better organization
                    for file_name in sorted(valid_files):
                        txt_file.write(f"{file_name}\n")
                        
                print(f"[SUCCESS] Created index at: {output_file_path}")
                
            except Exception as e:
                print(f"[ERROR] Could not write to {output_file_path}. Reason: {e}")

if __name__ == "__main__":
    # Replace '.' with your target folder path (e.g., "C:/Users/Name/Documents/University Assets")
    # Using '.' targets the exact folder where you run this script.
    target_folder = "." 
    
    generate_subdirectory_indexes(target_folder)
    print("\nScan completed successfully!")
