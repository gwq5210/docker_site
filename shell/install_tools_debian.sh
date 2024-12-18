#!/bin/sh

PKG=apt

# 安装工具, 安装zsh，zsh-autosuggestions，修改配置
$PKG update && $PKG upgrade -y && $PKG install -y htop wget dstat sysstat git vim curl openssl zsh telnet && \
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc && \
  sed -i 's/%c/[%\/]/g' ~/.oh-my-zsh/themes/robbyrussell.zsh-theme && \
  sed -i "s/# zstyle ':omz:update' mode disabled/zstyle ':omz:update' mode disabled/g" ~/.zshrc