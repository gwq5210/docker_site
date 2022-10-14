FROM python:3.7-slim

ADD . /app
WORKDIR /app

EXPOSE 5000

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

RUN apt-get update && pip3 install scrapydweb

CMD scrapydweb