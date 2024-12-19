#
# Dockerfile for scrapyd
#

FROM python:3.12-slim

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

RUN apt install gcc pkg-config libmariadb-dev-compat libmariadb-dev -y && pip3 install spider-admin-pro==3.0.9 PyMySQL mysql-connector mysqlclient

COPY ./spider_admin_pro/start_spider_admin_pro.sh ./env_from_file.sh /usr/local/bin/

VOLUME /var/lib/spider_admin_pro/
EXPOSE 8000

COPY ./spider_admin_pro/conf/* /etc/spider_admin_pro/

WORKDIR /usr/share/spider_admin_pro

CMD /usr/local/bin/start_spider_admin_pro.sh
