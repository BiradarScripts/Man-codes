import os
import zipfile

def unzip_all_in_folder(directory):
    # Walk through the directory
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".zip"):
                # Get the full path of the zip file
                file_path = os.path.join(root, file)
                print(f'Extracting {file_path}')
                
                # Define the folder where the zip content will be extracted
                extract_path = os.path.join(root, file[:-4])
                
                # Unzip the file
                with zipfile.ZipFile(file_path, 'r') as zip_ref:
                    zip_ref.extractall(extract_path)
                print(f'Extracted to {extract_path}')

if __name__ == "__main__":
    # Provide the path to the main folder where the zip files are located
    folder_path = "../../../T1-24-EGC 223 -Assignment-caches-11444"  # Change this to your target directory
    unzip_all_in_folder(folder_path)
