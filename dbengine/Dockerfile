# Use an official MySQL image as a parent image
FROM mysql:8.0-bookworm

WORKDIR /docker-entrypoint-initdb.d

# Copy the SQL file and the setup script
COPY ./dbmotor/kds_restaurante.sql /docker-entrypoint-initdb.d/kds_restaurante.sql

# Expose the MySQL port
EXPOSE 3306