#!/bin/bash

# Define the CSV file name
CSV_FILE="test_results_second.csv"

# Clear the CSV file if it exists (optional)
rm -f "$CSV_FILE"

# Function to run a test and log the results
run_test() {
  # Run the imageTest command with the provided parameters and capture the output
  output=$(./imageTest "$1" "$2")
  height=$(identify -format "%w" "$1")  # Get the image width (size) using ImageMagick's 'identify'
  width=$(identify -format "%h" "$1")  # Get the image height (size) using ImageMagick's 'identify'
  size=$((height * width))  # Calculate the image size

  # Check the exit status of the imageTest command (optional)
  if [ $? -eq 0 ]; then
    echo "Test successful: $@"
  else
    echo "Test failed: $@"
  fi
  # Extract and format the values (excluding the header)
  values=$(echo "$output" | tail -n +2 | sed 's/^[ \t]*//' | awk -v dim="$size" '{printf("%s, %s,%s,%s,%s\n", dim, $1, $2, $3, $4)}')

  # Append the formatted values to the CSV file
  echo "$values" >> "$CSV_FILE"
}

# Find all PGM files in subdirectories of 'pgm' and run tests
find pgm -type f -name "*.pgm" | while read -r file; do
  run_test "$file" filler.pgm
done

# Display a summary message
echo "All tests have been completed. Results (values only) are saved in $CSV_FILE."

