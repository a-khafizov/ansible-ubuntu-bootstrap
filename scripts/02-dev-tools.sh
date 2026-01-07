#!/bin/bash
set -e

echo "========================================="
echo "  Установка инструментов разработки"
echo "========================================="

if ! command -v code &> /dev/null; then
  sudo snap install --classic code
fi

read -p "Введите ваше имя для Git: " git_name
read -p "Введите ваш email для Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

echo ""
echo "✅ VS Code установлен"
echo "✅ Git настроен для: $git_name <$git_email>"