#!/bin/bash
set -e

echo "========================================="
echo "  Настройка безопасности и мониторинга"
echo "========================================="

if ! command -v ufw &> /dev/null; then
  sudo apt install -y ufw
fi

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw allow 3000/tcp
sudo ufw allow 8080/tcp
sudo ufw allow 8000/tcp

echo "y" | sudo ufw enable
sudo ufw status verbose

if ! command -v btop &> /dev/null; then
  sudo apt install -y btop
fi

if ! command -v chezmoi &> /dev/null; then
  sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$HOME/.local/bin"
fi

if ! command -v lazygit &> /dev/null; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz lazygit
fi

if ! command -v lazydocker &> /dev/null; then
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

echo ""
echo "✅ UFW настроен и включен"
echo "✅ btop установлен для мониторинга"
echo "✅ chezmoi установлен"
echo "✅ lazygit установлен"
echo "✅ lazydocker установлен"