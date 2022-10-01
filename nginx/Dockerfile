FROM nginx
# FROM soulteary/prebuilt-nginx-modules:ngx-1.21.1-echo-0.62-alpine

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell