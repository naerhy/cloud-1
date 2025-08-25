# Use the official Nginx image
FROM nginx:latest

ARG NGINX_DOMAIN_NAME
ARG NGINX_WWW_DOMAIN_NAME

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the main Nginx configuration
COPY nginx.conf /etc/nginx/

# Copy the server configuration
COPY nginx-server.conf /etc/nginx/conf.d/

# Update server name in server configuration
RUN sed -i "s/TO_REPLACE/${NGINX_DOMAIN_NAME} ${NGINX_WWW_DOMAIN_NAME}/g" /etc/nginx/conf.d/nginx-server.conf

RUN openssl req -x509 -noenc -days 7 -newkey rsa:2048 -sha512 \
    -keyout /etc/ssl/private/selfsigned.key \
    -out /etc/ssl/certs/selfsigned.crt \
    -subj="/C=FR/O=42Paris/CN=${NGINX_DOMAIN_NAME}" \
    -addext "subjectAltName = DNS:${NGINX_WWW_DOMAIN_NAME}"

# Expose port 443
EXPOSE 443

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
