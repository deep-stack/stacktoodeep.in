#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to copy the files from src to public
move_files() {
  # Define the source and destination directories
  SOURCE_DIR="$SCRIPT_DIR/../src"
  DEST_DIR="$SCRIPT_DIR/../public"

  # Copy all files and directories except for .md files from src to public
  rsync -av --exclude='*.md' "$SOURCE_DIR/" "$DEST_DIR"

  echo "All files and folders except .md files have been copied from src to public."
}


# Function to generate HTML files
build_html() {
  echo "Generating HTML files for all markdown file."
  
  SRC_DIR="$SCRIPT_DIR/../src"
  PUBLIC_DIR="$SCRIPT_DIR/../public"

  # Iterate over all markdown files in the src directory
  for md_file in "$SRC_DIR"/*.md; do
    filename=$(basename -- "$md_file")
    name="${filename%.*}"
    
    # Generate HTML for each markdown file
    pandoc --toc -s --css "reset.css" --css "index.css" \
      -i "$md_file" -o "$PUBLIC_DIR/$name.html" --template="$SCRIPT_DIR/../templates/index.html"
    
    if [ $? -eq 0 ]; then
      echo "public/$name.html generated successfully."  
    else
      echo "Error: Failed to generate public/$name.html."
      return 1
    fi
  done
}

# Function to clean
clean() {
  PUBLIC_DIR="$SCRIPT_DIR/../public"
  echo "Cleaning generated files..."

  for file in "$PUBLIC_DIR"/*; do
    # Skip the specific files
    if [[ "$file" == *.css || "$file" == *.js ]]; then
      echo "Skipping: $file"
      continue
    fi

    rm -rf "$file"

    if [ $? -eq 0 ]; then
      echo "Removed: $file"
    else
      echo "Error: Failed to remove $file."
      exit 1
    fi
  done

  echo "All generated files have been removed."
}

# Parse command-line arguments
if [ "$1" == "clean" ]; then
  clean
elif [ "$1" == "move-files" ]; then
  move_files
elif [ "$1" == "build-html" ]; then
  build_html
else
  move_files
  build_html
fi
