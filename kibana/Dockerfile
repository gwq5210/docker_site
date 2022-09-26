FROM kibana:7.17.6

USER root

COPY ../shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell

USER kibana