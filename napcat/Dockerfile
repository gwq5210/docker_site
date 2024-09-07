FROM ubuntu:22.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai


COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnotify4 \
    libsecret-1-0 \
    libgbm1 \
    xvfb \
    libasound2 \
    fonts-wqy-zenhei \
    gnutls-bin \
    libglib2.0-dev \
    libdbus-1-3 \
    libgtk-3-0 \
    libxss1 \
    libxtst6 \
    libatspi2.0-0 \
    libx11-xcb1 \
    ffmpeg \
    unzip \
    dbus-user-session \
    curl \
    gosu \
    tzdata && \
    echo "${TZ}" > /etc/timezone && \ 
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN useradd --no-log-init -d /app napcat

WORKDIR /app

RUN cd /app && wget https://github.com/NapNeko/NapCatQQ/releases/download/v2.2.12/NapCat.Shell.zip \
    && unzip -q NapCat.Shell.zip -d ./NapCat.Shell \
    && mkdir -p napcat/config \
    && mv NapCat.Shell/config/* napcat/config/ \
    && rmdir NapCat.Shell/config \
    && mv NapCat.Shell/* napcat/

COPY ./napcat/entrypoint.sh /app/

COPY ./env_from_file.sh /usr/local/bin

COPY napcat/conf /etc/napcat

# 安装Linux QQ
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    curl -o linuxqq.deb https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.12_240819_${arch}_01.deb && \
    dpkg -i --force-depends linuxqq.deb && rm linuxqq.deb && \
    chmod +x entrypoint.sh && \
    echo "(async () => {await import('file:///app/napcat/napcat.mjs');})();" > /opt/QQ/resources/app/app_launcher/index.js

VOLUME /app/napcat/config
VOLUME /app/.config/QQ

ENTRYPOINT ["bash", "entrypoint.sh"]