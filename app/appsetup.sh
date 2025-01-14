#!/bin/bash
set -e  # Detener el script si falla algún comando

# Instalar dependencias de Composer
composer install --no-interactive --optimize-autoloader

# Configuración del archivo .env
if [ ! -f .env ]; then
    cp .env.example .env
    php artisan key:generate
fi

# Crear enlace simbólico para storage
php artisan storage:link

# Establecer permisos
sudo chown -R www-data:www-data /var/www/kds_restaurante/
sudo chmod -R 755 /var/www/kds_restaurante/

echo "Setting permissions..."
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
sudo chmod +x artisan

# Instalación de dependencias de Node
if [ ! -d "node_modules" ] || [ -z "$(ls -A node_modules)" ]; then
    echo "Installing Node dependencies..."
    yarn install
    yarn run dev
    yarn run prod
fi

# Configuración del entorno
cat > .env << EOL
APP_ENV=local
DB_CONNECTION=mysql
DB_HOST=dbmotor
DB_PORT=3306
DB_DATABASE=kds_restaurante
DB_USERNAME=root
DB_PASSWORD=mysecretkey
PUSHER_APP_ID=local
PUSHER_APP_KEY=local
PUSHER_APP_SECRET=local
PUSHER_APP_CLUSTER=mt1
PUSHER_APP_NAME=laravel
WEBSOCKETS_PORT=6001
WEBSOCKETS_ALLOWED_ORIGIN=*
MIX_PUSHER_APP_KEY=local
MIX_PUSHER_APP_CLUSTER=mt1
MIX_PUSHER_HOST=127.0.0.1

PRINTER_CAJA=SHARED
PRINTER_BARRA=SHARED
PRINTER_COCINA=SHARED
PRINTER_NETWORK_CAJA=192.168.1.100
PRINTER_NETWORK_BARRA=192.168.1.100
PRINTER_NETWORK_COCINA=192.168.1.100
PRINTER_SHARED_COCINA=smb://ClickandCars2/POS-80
PRINTER_SHARED_BARRA=smb://DESKTOP-RDV3MK0/caja
PRINTER_SHARED_CAJA=smb://DESKTOP-RDV3MK0/caja
PRINTER_OFF=false
EOL

# Mantener el contenedor en ejecución
tail -f /dev/null