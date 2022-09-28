FROM v2fly/v2fly-core

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

COPY ./env_from_file.sh ./v2ray/start_v2ray.sh /usr/bin/

CMD start_v2ray.sh > /var/log/v2ray/v2ray.log