FROM php:7.4-apache
RUN pecl install mongodb && docker-php-ext-enable mongodb
COPY --from=composer:2.0.6 /usr/bin/composer /usr/bin/composer
RUN apt update && apt install -y git
RUN composer require mongodb/mongodb
COPY . /var/www/html/
RUN ["/bin/bash", "-c", "chmod +x /var/www/html/*"]