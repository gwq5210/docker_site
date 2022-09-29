FROM easypi/scrapyd:latest

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

COPY ./scrapyd/start_scrapyd.sh ./env_from_file.sh ./

CMD ./start_scrapyd.sh >> /var/log/scrapyd/start_scrapyd.log 2>&1