FROM portainer/portainer-ee:2.15.1-alpine

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell