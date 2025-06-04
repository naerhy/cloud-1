FROM mariadb:latest

# Set the volume for the MariaDB data
VOLUME /var/lib/mysql

# Expose the MariaDB port
EXPOSE 3306

# Add a health check to ensure the database is ready
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" --execute="SELECT 1;" || exit 1