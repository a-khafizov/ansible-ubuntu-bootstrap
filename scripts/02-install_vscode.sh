#!/bin/bash
set -e

echo "Установка VS Code..."

if ! command -v code &> /dev/null; then
  echo "Устанавливаем VS Code через Snap..."
  sudo snap install --classic code
  echo "VS Code успешно установлен"
else
  echo "VS Code уже установлен"
fi
