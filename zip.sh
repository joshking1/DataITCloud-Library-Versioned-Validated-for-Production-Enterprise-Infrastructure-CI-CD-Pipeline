#!/bin/bash
# we are going to check the code 
# Change to the /opt directory
cd /opt

# Create a zip archive of all files in the directory
zip -r opt_files.zip ./*

# Print a message indicating the script has completed
echo "Finished creating zip archive of /opt directory"
