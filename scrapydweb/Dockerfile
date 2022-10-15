FROM python:3.7-slim

WORKDIR /app

EXPOSE 5000

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

RUN pip3 install Flask-SQLAlchemy==2.5.1 && apt-get update && apt-get install -y git && \
  pip3 install -U git+https://github.com/gwq5210/scrapydweb.git
RUN cp /usr/local/lib/python3.7/site-packages/scrapydweb/default_settings.py scrapydweb_settings_v10.py

CMD scrapydweb