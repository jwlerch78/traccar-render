FROM traccar/traccar:latest

# Copy in our custom entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Render’s assigned port (will be injected at runtime as $PORT)
EXPOSE 10000

# Use our entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
