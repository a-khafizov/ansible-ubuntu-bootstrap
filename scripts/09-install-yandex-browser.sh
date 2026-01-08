#!/bin/bash
set -e

echo "Установка Яндекс Браузера"

# Проверка, установлен ли браузер
if command -v yandex-browser &> /dev/null; then
    echo "Яндекс Браузер уже установлен"
    exit 0
fi

# Добавление репозитория Яндекс Браузера
wget -O- https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add -
echo "deb [arch=amd64] https://repo.yandex.ru/yandex-browser/deb stable main" | sudo tee /etc/apt/sources.list.d/yandex-browser.list

# Установка Яндекс Браузера
sudo apt update
sudo apt install -y yandex-browser-stable

echo "Яндекс Браузер успешно установлен"