FROM v2fly/v2fly-core:v4.45.2

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

COPY ./env_from_file.sh ./v2ray/start_v2ray.sh ./

CMD ./start_v2ray.sh >> /var/log/v2ray/v2ray.log 2>&1