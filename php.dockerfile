FROM php:8.4-fpm-alpine

WORKDIR /var/www/html

COPY . .

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN addgroup --system nelwhix
RUN adduser -G nelwhix --system -D -s /bin/sh nelwhix

RUN sed -i "s/user = www-data/user = nelwhix/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = nelwhix/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

# Grant ownership and permissions
RUN chown -R nelwhix:nelwhix /var/www/html
RUN chmod -R 755 /var/www/html
    
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]