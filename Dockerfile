FROM ubuntu:latest

# Copy the script into the container
COPY ubuntu.sh /ubuntu.sh

# Make the script executable
RUN chmod +x /ubuntu.sh

# Set the script as the entry point
ENTRYPOINT ["/ubuntu.sh"]
