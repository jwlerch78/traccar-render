# Use the official Traccar image
FROM traccar/traccar:latest

# Copy your custom entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port that Render will assign at runtime
ARG PORT=10000
ENV PORT=$PORT
EXPOSE $PORT

# Use the custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
