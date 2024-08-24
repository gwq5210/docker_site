FROM openjdk:11-jre

WORKDIR /usr/share/mirai

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell && \
  wget https://github.com/iTXTech/mirai-console-loader/releases/download/v2.1.2/mcl-2.1.2.zip && \
  unzip mcl-2.1.2.zip && rm mcl-2.1.2.zip && chmod +x mcl && \
  ./mcl --update-package net.mamoe:mirai-api-http --type plugin --channel stable-v2 && \
  ./mcl --update-package net.mamoe:chat-command --type plugin --channel stable && \
  ./mcl --dry-run && \
  wget -O plugins/mirai-login-solver-sakura-0.0.12.mirai2.jar https://github.com/KasukuSakura/mirai-login-solver-sakura/releases/download/v0.0.12/mirai-login-solver-sakura-0.0.12.mirai2.jar && \
  ./mcl --disable-module updater && echo "exit" | ./mcl

VOLUME [ "/usr/share/mirai/bots" ]

COPY ./mirai/start_mcl.sh ./env_from_file.sh /usr/share/mirai/

CMD ./start_mcl.sh >> logs/mcl.log 2>&1
