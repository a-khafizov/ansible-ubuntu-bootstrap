#!/bin/bash
set -e

echo "Настройка Git..."

# Проверяем, переданы ли параметры командной строки
if [ $# -eq 2 ]; then
    git_name="$1"
    git_email="$2"
else
    # Проверяем, запущен ли скрипт в интерактивном режиме
    if [ -t 0 ]; then
        # Интерактивный режим - запрашиваем данные у пользователя
        read -p "Введите ваше имя для Git: " git_name
        read -p "Введите ваш email для Git: " git_email
    else
        # Автоматический режим - используем значения по умолчанию
        git_name="Developer"
        git_email="developer@localhost"
        echo "Используются значения по умолчанию: $git_name <$git_email>"
    fi
fi

git config --global user.name "$git_name"      # Имя пользователя
git config --global user.email "$git_email"    # Email пользователя
git config --global core.editor "code --wait"  # VS Code как редактор по умолчанию
git config --global init.defaultBranch main    # Основная ветка по умолчанию
git config --global pull.rebase false          # Отключить rebase при pull

echo "Git настроен для: $git_name <$git_email>"