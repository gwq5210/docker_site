FROM gwq5210/ubuntu_dev:latest

RUN curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
  echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
  apt update && apt upgrade -y && apt install -y elasticsearch kibana