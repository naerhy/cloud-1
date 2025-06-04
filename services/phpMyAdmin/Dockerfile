# Use the official phpMyAdmin image
FROM phpmyadmin:latest

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Expose port 80 to allow external access to phpMyAdmin
EXPOSE 80

# Add healthcheck to verify web server is accessible
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:80/ || exit 1