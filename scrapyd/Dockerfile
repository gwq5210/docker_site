#
# Dockerfile for scrapyd
#

FROM python:3.12-slim

COPY ./scrapyd/conf/scrapyd.conf /etc/scrapyd/
RUN pip3 install scrapy==2.11.2 scrapyd==1.4.3
VOLUME /var/lib/scrapyd/
EXPOSE 6800

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

COPY ./scrapyd/start_scrapyd.sh ./env_from_file.sh /usr/local/bin/

WORKDIR /usr/share/scrapyd

CMD /usr/local/bin/start_scrapyd.sh >> /var/log/scrapyd/start_scrapyd.log 2>&1
