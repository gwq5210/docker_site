FROM ubuntu

# 安装工具, 安装zsh，zsh-autosuggestions，修改配置
RUN apt update && apt upgrade -y && apt install -y htop wget dstat sysstat git vim curl openssl zsh && \
  usermod -s /usr/bin/zsh root && \
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc && \
  sed -i 's/%c/[$PWD]/g' ~/.oh-my-zsh/themes/robbyrussell.zsh-theme