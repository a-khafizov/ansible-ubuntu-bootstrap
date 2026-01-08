#!/bin/bash
set -e

echo "  Настройка безопасности и мониторинга"

if ! command -v ufw &> /dev/null; then
  echo "Установка UFW (фаервол)..."
  sudo apt install -y ufw
fi

echo "Настройка базовых правил UFW..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw allow 3000/tcp comment "React/Vue dev server"
sudo ufw allow 8080/tcp comment "Spring/Go applications"
sudo ufw allow 8000/tcp comment "Python Django/Flask"

echo "y" | sudo ufw enable
echo "Статус UFW:"
sudo ufw status verbose

if ! command -v btop &> /dev/null; then
  echo "Установка btop (мониторинг)..."
  sudo apt install -y btop
else
  echo "btop уже установлен"
fi

if ! command -v chezmoi &> /dev/null; then
  echo "Установка chezmoi (управление dotfiles)..."
  sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$HOME/.local/bin"
else
  echo "chezmoi уже установлен"
fi

if ! command -v lazygit &> /dev/null; then
  echo "Установка lazygit (TUI для Git)..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz lazygit
else
  echo "lazygit уже установлен"
fi

if ! command -v lazydocker &> /dev/null; then
  echo "Установка lazydocker (TUI для Docker)..."
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
  echo "lazydocker уже установлен"
fi

echo "UFW настроен и включен"
echo "btop установлен для мониторинга"
echo "chezmoi установлен для управления dotfiles"
echo "lazygit установлен (TUI для Git)"
echo "lazydocker установлен (TUI для Docker)"