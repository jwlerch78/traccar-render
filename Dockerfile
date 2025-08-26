FROM traccar/traccar:latest

# Copy our entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Run through our script instead of default
ENTRYPOINT ["/entrypoint.sh"]
