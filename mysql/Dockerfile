FROM mysql:8.0.31

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell