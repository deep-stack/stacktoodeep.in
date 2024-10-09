#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to move assets from to public directory except markdown files
move_files() {
  # Define the source and destination directories
  SOURCE_DIR="$SCRIPT_DIR/../src"
  DEST_DIR="$SCRIPT_DIR/../public"

  # Copy all files and directories except for .md files from src to public
  rsync -av --exclude='*.md' --exclude='blogs/pages' "$SOURCE_DIR/" "$DEST_DIR"

  echo "All files and folders except .md files have been copied from src to public."
}


# Function to generate HTML files for index and blogs
build_html() {
  echo "Generating HTML files for each blog..."
  
  BLOGS_DIR="$SCRIPT_DIR/../src/blogs/pages"
  PUBLIC_DIR="$SCRIPT_DIR/../public"
  
  # Generate HTML for index.md
  echo "Generating index.html from index.md..."
  pandoc --toc -s --css "reset.css" --css "index.css" \
    -i "$SCRIPT_DIR/../src/index.md" -o "$SCRIPT_DIR/../public/index.html" --template="$SCRIPT_DIR/../templates/index.html"
  
  if [ $? -eq 0 ]; then
    echo "public/index.html generated successfully."
  else
    echo "Error: Failed to generate public/index.html."
    return 1
  fi

  if [ ! -d "$BLOGS_DIR" ]; then
    echo "Error: $BLOGS_DIR does not exist. Aborting."
    exit 1
  fi

  # Iterate over all .md files in the blogs directory
  for md_file in "$BLOGS_DIR"/*.md; do
    filename=$(basename -- "$md_file")
    name="${filename%.*}"
    
    # Generate HTML for each markdown file
    pandoc --toc -s --css "reset.css" --css "index.css" \
      -i "$md_file" -o "$PUBLIC_DIR/$name.html" --template="$SCRIPT_DIR/../templates/blogs.html"
    
    if [ $? -eq 0 ]; then
      echo "$PUBLIC_DIR/$name.html generated successfully."  
    else
      echo "Error: Failed to generate $PUBLIC_DIR/$name.html."
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
    if [[ "$file" == "$PUBLIC_DIR/reset.css" || "$file" == "$PUBLIC_DIR/index.js" || "$file" == "$PUBLIC_DIR/index.css" ]]; then
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
elif [ "$1" == "move-codeblocks" ]; then
  move_files
elif [ "$1" == "build-html" ]; then
  build_html
else
  move_files
  build_html
fi
