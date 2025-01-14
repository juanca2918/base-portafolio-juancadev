FROM php:7.4.33-fpm

WORKDIR /var/www/

RUN apt-get update && apt-get install -y \
    curl \
    git \
    libzip-dev \
    libonig-dev \
    libpng-dev \
    libxml2-dev \
    unzip \
    libssl-dev \
    libexif-dev \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libicu-dev \
    libpq-dev \
    zlib1g-dev \
    g++ \
    libcurl4-openssl-dev \
    && apt-get install -y dos2unix

# Configurar GD para PHP 7.4
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/

# Instalar extensiones PHP requeridas
RUN docker-php-ext-install -j$(nproc) \
    gd \
    zip \
    mbstring \
    pcntl \
    bcmath \
    mysqli \
    pdo_mysql \
    xml \
    intl \
    opcache \
    pdo_pgsql \
    dom

# Instalar Redis
RUN pecl install redis && docker-php-ext-enable redis

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Setup Node.js repository
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# Setup Yarn repository properly
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/yarn.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
        
RUN apt-get update && apt-get install -y nodejs yarn

RUN apt-get update && apt-get install -y \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Crear el directorio para el socket
RUN mkdir -p /run/php && \
    chown www-data:www-data /run/php

# Copiar la configuración de php-fpm
COPY ./app/php-fpm.conf /usr/local/etc/php/conf.d/appkds.conf

COPY ./app/KDS_Restaurant /var/www/kds_restaurante
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./app/appsetup.sh /var/www/kds_restaurante/appsetup.sh
RUN chmod +x /var/www/kds_restaurante/appsetup.sh
WORKDIR /var/www/kds_restaurante

EXPOSE 80

CMD ["php-fpm"]