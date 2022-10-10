FROM easypi/scrapyd:latest

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

RUN git clone https://github.com/gwq5210/spider.git && pip3 install -r spider/requirements.txt && rm -rf spider

COPY ./scrapyd/start_scrapyd.sh ./env_from_file.sh /usr/local/bin/

WORKDIR /usr/share/scrapyd

CMD /usr/local/bin/start_scrapyd.sh >> /var/log/scrapyd/start_scrapyd.log 2>&1
