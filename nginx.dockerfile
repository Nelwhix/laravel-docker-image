FROM nginx:stable-alpine

RUN addgroup --system nelwhix
RUN adduser -G nelwhix --system -D -s /bin/sh nelwhix
RUN sed -i "s/user  nginx/user nelwhix/g" /etc/nginx/nginx.conf

ADD ./nginx/default.conf /etc/nginx/conf.d/

COPY . /var/www/html

# Grant ownership and permissions
RUN chown -R nelwhix:nelwhix /var/www/html
RUN chmod -R 755 /var/www/html