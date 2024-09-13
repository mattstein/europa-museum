FROM serversideup/php:8.3-fpm-nginx

# More options: https://serversideup.net/open-source/docker-php/docs/reference/environment-variable-specification
ENV PHP_OPCACHE_ENABLE=1
ENV NGINX_WEBROOT=/var/www/html/web

# Switch to root so we can do root things
USER root

# Install PHP extensions
RUN install-php-extensions bcmath gd imagick/imagick@master iconv intl json reflection spl

# Install Node.js v20
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Copy this entire project structure to the web root
COPY --chown=www-data:www-data . /var/www/html

USER www-data

RUN npm install
RUN npm run build

RUN composer install --no-interaction --optimize-autoloader --no-dev
