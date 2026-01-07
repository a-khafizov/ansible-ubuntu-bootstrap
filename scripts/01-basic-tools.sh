#!/bin/bash
set -e

echo "========================================="
echo "  Установка базовых системных утилит"
echo "========================================="

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
  curl \
  wget \
  git \
  build-essential \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release \
  unzip \
  zip \
  net-tools \
  tree \
  htop \
  ncdu \
  nethogs \
  jq \
  yq \
  fzf \
  ripgrep \
  bat \
  fd-find

if [ -f /usr/bin/batcat ] && [ ! -f /usr/bin/bat ]; then
  sudo ln -s /usr/bin/batcat /usr/bin/bat
fi

if [ -f /usr/bin/fdfind ] && [ ! -f /usr/bin/fd ]; then
  sudo ln -s /usr/bin/fdfind /usr/bin/fd
fi

echo ""
echo "✅ Базовые утилиты установлены"