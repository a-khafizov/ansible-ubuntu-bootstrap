#!/bin/bash
set -e

echo "Установка кастомных инструментов разработки"

# Директория для пользовательских бинарников
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

# Управление dotfiles (синхронизация конфигураций между системами)
if ! command -v chezmoi &> /dev/null; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$BIN_DIR"
fi

# TUI-клиент для Git с удобным интерфейсом
if ! command -v lazygit &> /dev/null; then
    # Получаем последнюю версию из GitHub Releases
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    # Скачиваем и распаковываем бинарник
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    # Устанавливаем в системную директорию
    sudo install lazygit /usr/local/bin
    # Очищаем временные файлы
    rm -f lazygit.tar.gz lazygit
fi

# TUI-клиент для управления Docker-контейнерами и образами
if ! command -v lazydocker &> /dev/null; then
    curl -s https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

# Добавляем ~/.local/bin в PATH для доступа к установленным инструментам
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> ~/.bashrc
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> ~/.zshrc 2>/dev/null || true
fi

echo "Инструменты установлены"
echo "chezmoi   - управление dotfiles (конфигурациями)"
echo "lazygit   - терминальный интерфейс для Git"
echo "lazydocker - терминальный интерфейс для Docker"