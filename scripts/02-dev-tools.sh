#!/bin/bash
set -e

echo "========================================="
echo "  Установка инструментов разработки"
echo "========================================="

if ! command -v code &> /dev/null; then
  echo "Установка VS Code..."
  sudo snap install --classic code
else
  echo "VS Code уже установлен"
fi

read -p "Введите ваше имя для Git: " git_name
read -p "Введите ваш email для Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main
git config --global pull.rebase false

echo ""
echo "✅ VS Code установлен"
echo "✅ Git настроен для: $git_name <$git_email>"