#!/bin/bash
set -e

echo "========================================="
echo "  Настройка терминала и оболочки"
echo "========================================="

if ! command -v zsh &> /dev/null; then
  sudo apt install -y zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if ! command -v starship &> /dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

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
  chsh -s $(which zsh)
  echo "⚠️  Оболочка изменена на Zsh. Выйдите и войдите заново."
fi

echo ""
echo "✅ Zsh + Oh My Zsh + Starship установлены"
echo "✅ Плагины добавлены"
echo "✅ Алиасы настроены"