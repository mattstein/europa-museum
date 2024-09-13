FROM serversideup/php:8.3-fpm-nginx

ENV PHP_OPCACHE_ENABLE=1
ENV NGINX_WEBROOT=/var/www/html/web

# Switch to root so we can do root things
USER root

# Install PHP extensions
RUN install-php-extensions gd imagick/imagick@master iconv intl

# Install Node.js v20
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Copy this entire project structure to the web root
COPY --chown=www-data:www-data . /var/www/html

USER www-data

# Install npm dependencies and build
RUN npm install
RUN npm run build

# Install Composer dependencies and run Craft migrations + project config sync
RUN composer install --no-interaction --optimize-autoloader --no-dev
RUN php craft up --interactive=0
