FROM php:7.4-fpm

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

# https://github.com/renatomefi/php-fpm-healthcheck
# Enable php fpm status page
RUN apt install -y libfcgi-bin && set -xe && echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf && wget -O /usr/local/bin/php-fpm-healthcheck \
  https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck && \
  chmod +x /usr/local/bin/php-fpm-healthcheck