#!/bin/bash
set -e

echo "========================================="
echo "  Настройка терминала и оболочки"
echo "========================================="

if ! command -v zsh &> /dev/null; then
  echo "Установка Zsh..."
  sudo apt install -y zsh
else
  echo "Zsh уже установлен"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Установка Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh уже установлен"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Установка плагина zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Установка плагина zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if ! command -v starship &> /dev/null; then
  echo "Установка Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "Starship уже установлен"
fi

echo "Настройка .zshrc..."
cat > ~/.zshrc << 'ZSH_CONFIG'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  docker
  docker-compose
  kubectl
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias d='docker'
alias dc='docker compose'
alias k='kubectl'
ZSH_CONFIG

if [[ $SHELL != *"zsh"* ]]; then
  echo "Смена оболочки по умолчанию на Zsh..."
  chsh -s $(which zsh)
  echo "⚠️  Оболочка изменена на Zsh. Выйдите и войдите заново для применения."
fi

echo ""
echo "✅ Zsh + Oh My Zsh + Starship установлены"
echo "✅ Плагины добавлены"
echo "✅ Алиасы настроены"