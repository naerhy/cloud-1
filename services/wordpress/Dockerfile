FROM wordpress:php8.2-fpm-alpine

# Install required packages
RUN apk update && apk add --no-cache \
    curl \
    bash \
    less \
    mariadb-client

# Configure PHP
RUN set -ex; \
    { \
        echo 'upload_max_filesize = 128M'; \
        echo 'post_max_size = 128M'; \
        echo 'memory_limit = 256M'; \
        echo 'max_execution_time = 300'; \
        echo 'max_input_vars = 2000'; \
        echo 'date.timezone = "UTC"'; \
    } > /usr/local/etc/php/conf.d/wordpress-recommended.ini

# Define working directory
WORKDIR /var/www/html

# Use non-root user (www-data)
USER www-data

# Expose the FPM port
EXPOSE 9000

# Add healthcheck to verify web server is accessible
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s --retries=3 \
  CMD php -r "if(file_exists('/var/www/html/wp-includes/version.php')) { exit(0); } else { exit(1); }"

CMD ["php-fpm"]