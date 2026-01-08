#!/bin/bash
set -e

echo "Настройка базовой безопасности"

# Установка UFW если не установлен
if ! command -v ufw &> /dev/null; then
    sudo apt install -y ufw
fi

echo "Настройка правил UFW..."

sudo ufw default deny incoming   # Блокировать все входящие
sudo ufw default allow outgoing  # Разрешить все исходящие

# Проверяем, установлен ли SSH сервер перед добавлением правила
if systemctl is-active --quiet ssh; then
    sudo ufw allow OpenSSH        # Разрешить SSH (порт 22)
    echo "Правило OpenSSH добавлено"
else
    echo "SSH сервер не активен, правило OpenSSH пропущено"
fi

echo "y" | sudo ufw enable       # Включить фаервол (автоподтверждение)

echo "Статус UFW:"
sudo ufw status

echo "Базовая безопасность настроена"