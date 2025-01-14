#!/bin/bash
set -e

MYSQL_ROOT_PASSWORD="mysecretpassword"
MYSQL_DATABASE="kds_restaurante"
SQL_FILE="/home/kds_restaurante.sql"
SOCKET_PATH="/var/run/mysqld/mysqld.sock"

# Crear la base de datos si no existe
echo "Verificando y creando la base de datos si no existe..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
EOSQL

# Verificar si el archivo SQL existe y ejecutarlo
if [ -f "$SQL_FILE" ]; then
    echo "Ejecutando el archivo SQL: $SQL_FILE"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$SQL_FILE"
else
    echo "Archivo SQL no encontrado: $SQL_FILE"
    exit 1
fi
