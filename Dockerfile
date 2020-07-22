FROM php:7.3-apache

RUN apt update && apt install libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev -y 

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN docker-php-ext-install \
    bcmath \
    pdo_mysql 

COPY index.php /var/www/html
COPY 000-default.conf /etc/apache2/sites-available

RUN a2enmod rewrite && service apache2 restart

EXPOSE 80
WORKDIR /var/www/html
