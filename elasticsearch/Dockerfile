FROM elasticsearch:7.17.6

COPY ./shell shell

RUN ./shell/install_tools.sh && rm -rf ./shell && echo "y" | /usr/share/elasticsearch/bin/elasticsearch-plugin \
  install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.17.6/elasticsearch-analysis-ik-7.17.6.zip

VOLUME [ "/usr/share/elasticsearch/data" ]