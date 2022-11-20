FROM nextcloud:fpm

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

RUN apt update && apt install -y ffmpeg