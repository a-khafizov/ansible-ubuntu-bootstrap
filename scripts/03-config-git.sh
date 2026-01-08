#!/bin/bash
set -e

echo "Настройка Git..."

read -p "Введите ваше имя для Git: " git_name
read -p "Введите ваш email для Git: " git_email

git config --global user.name "$git_name"      # Имя пользователя
git config --global user.email "$git_email"    # Email пользователя
git config --global core.editor "code --wait"  # VS Code как редактор по умолчанию
git config --global init.defaultBranch main    # Основная ветка по умолчанию
git config --global pull.rebase false          # Отключить rebase при pull

echo "Git настроен для: $git_name <$git_email>"