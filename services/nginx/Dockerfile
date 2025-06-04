# Use the official Nginx image
FROM nginx:latest

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the main Nginx configuration
COPY nginx.conf /etc/nginx/

# Copy the server configuration
COPY nginx-server.conf /etc/nginx/conf.d/

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
