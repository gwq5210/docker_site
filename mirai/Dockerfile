FROM openjdk:11-jre

WORKDIR /root/mirai

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell && \
  wget https://github.com/iTXTech/mirai-console-loader/releases/download/v2.1.1/mcl-2.1.1.zip && \
  unzip mcl-2.1.1.zip && rm mcl-2.1.1.zip && chmod +x mcl && \
  ./mcl --update-package net.mamoe:mirai-api-http --type plugin --channel stable-v2 && \
  ./mcl --update-package net.mamoe:chat-command --type plugin --channel stable && \
  ./mcl --dry-run && mkdir -p /usr/share/mirai/logs

EXPOSE 8080

VOLUME [ "/root/mirai/bots" ]

COPY ./mirai/start_mcl.sh ./env_from_file.sh /root/mirai/

CMD ./start_mcl.sh > logs/mcl.log
