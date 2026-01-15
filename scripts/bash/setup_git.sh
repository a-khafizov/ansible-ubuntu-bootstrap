#!/bin/bash

echo "Обновление пакетов и установка Git..."
sudo apt update
sudo apt install -y git

echo "Настройка Git..."
read -p "Введите ваше имя для Git: " git_name
read -p "Введите ваш email для Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global color.ui auto
git config --global core.editor "code --wait"

echo "Текущая конфигурация:"
echo "Имя: $(git config --global user.name)"
echo "Email: $(git config --global user.email)"