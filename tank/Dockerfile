# use golang 1.17
FROM golang:1.17

# work directory.
WORKDIR /data

# proxy
ENV GOPROXY=https://goproxy.cn

# Handle time-zone
ENV TZ=Asia/Shanghai

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell && apt install -y tzdata

RUN git clone https://github.com/gwq5210/tank.git . && go build && cp -r /data/tank /data/build/

# in order to make docker stateless. Prepare a volumn
VOLUME /data/build/matter

# use 6010 as default.
EXPOSE 6010

# tank as execute file.
ENTRYPOINT ["/data/build/tank"]
