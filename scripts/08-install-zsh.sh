#!/bin/bash
set -e

echo "Настройка терминала и оболочки"

# Установка Zsh (альтернатива bash с улучшенными возможностями)
if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
fi

# Установка Oh My Zsh (фреймворк для управления Zsh)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Установка плагина автодополнения команд
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Установка плагина подсветки синтаксиса
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Установка Starship (кросс-оболочечный промпт)
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Настройка конфигурации Zsh
echo "Настройка .zshrc..."
cat > ~/.zshrc << 'ZSH_CONFIG'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git docker docker-compose kubectl       # Плагины для разработки
  zsh-autosuggestions zsh-syntax-highlighting # UI улучшения
)

source $ZSH/oh-my-zsh.sh                  # Инициализация Oh My Zsh
eval "$(starship init zsh)"               # Инициализация Starship

alias ll='ls -la'                         # Детальный список файлов
alias gs='git status' alias gp='git pull' # Git алиасы
alias d='docker' alias dc='docker compose' alias k='kubectl' # Dev алиасы
ZSH_CONFIG

# Смена оболочки по умолчанию на Zsh
if [[ $SHELL != *"zsh"* ]]; then
    chsh -s $(which zsh)
    echo "Оболочка изменена на Zsh. Выйдите и войдите заново."
fi

echo "Zsh + Oh My Zsh + Starship установлены"