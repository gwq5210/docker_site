FROM nginx:1.21.1

COPY --from=soulteary/prebuilt-nginx-modules:ngx-1.21.1-echo-0.62 /ngx_http_echo_module.so /etc/nginx/modules/

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell