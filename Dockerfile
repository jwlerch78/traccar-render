FROM traccar/traccar:latest

# Copy your entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make sure it's executable
RUN chmod +x /entrypoint.sh

# Use your script as the startup command
ENTRYPOINT ["/entrypoint.sh"]
