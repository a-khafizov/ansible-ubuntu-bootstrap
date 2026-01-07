# Ubuntu Developer Environment Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Полное руководство по настройке современного рабочего окружения разработчика на Ubuntu GNOME.

## 📋 Содержание

- [Быстрый старт](#⚡-быстрый-старт)
- [Пошаговая настройка](#-пошаговая-настройка)
  - [1. Системные обновления и базовые утилиты](#1-системные-обновления-и-базовые-утилиты)
  - [2. Основные инструменты разработки](#2-основные-инструменты-разработки)
  - [3. Контейнеризация и оркестрация](#3-контейнеризация-и-оркестрация)
  - [4. Базы данных и GUI клиенты](#4-базы-данных-и-gui-клиенты)
  - [5. API тестирование](#5-api-тестирование)
  - [6. Браузер](#6-браузер)
  - [7. Терминал и оболочка](#7-терминал-и-оболочка)
  - [8. Инструменты для продуктивности](#8-инструменты-для-продуктивности)
  - [9. Безопасность и мониторинг](#9-безопасность-и-мониторинг)
- [🔧 Проверка установки](#-проверка-установки)
- [🔄 Обновление окружения](#-обновление-окружения)
- [🚀 Рекомендации](#-рекомендации)
- [🐛 Устранение неполадок](#-устранение-неполадок)

## ⚡ Быстрый старт

```bash
chmod +x setup.sh
./setup.sh

Или запускайте скрипты по отдельности из папки scripts/.

🛠️ Пошаговая настройка
1. Системные обновления и базовые утилиты
bash
./scripts/01-basic-tools.sh
2. Основные инструменты разработки
bash
./scripts/02-dev-tools.sh
3. Контейнеризация и оркестрация
bash
./scripts/03-docker-k8s.sh
4. Базы данных и GUI клиенты
bash
./scripts/04-database-tools.sh
5. API тестирование
Установка вручную:

bash
# Postman
sudo snap install postman

# Insomnia
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee /etc/apt/sources.list.d/insomnia.list
sudo apt update
sudo apt install -y insomnia
6. Браузер
bash
# Yandex Browser
wget https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-beta/yandex-browser-beta_1.0.0-1_amd64.deb
sudo dpkg -i yandex-browser-beta_1.0.0-1_amd64.deb
sudo apt install -f -y
rm yandex-browser-beta_1.0.0-1_amd64.deb
7. Терминал и оболочка
bash
./scripts/05-terminal-setup.sh
8. Инструменты для продуктивности
bash
# Устанавливаются в скрипте 06-security-monitoring.sh
9. Безопасность и мониторинг
bash
./scripts/06-security-monitoring.sh
🔧 Проверка установки
bash
./setup.sh  # Выберите опцию 3
Или вручную:

bash
command -v code && echo "✓ VS Code" || echo "✗ VS Code"
command -v docker && echo "✓ Docker" || echo "✗ Docker"
command -v kubectl && echo "✓ kubectl" || echo "✗ kubectl"
command -v psql && echo "✓ PostgreSQL Client" || echo "✗ PostgreSQL Client"
🔄 Обновление окружения
bash
# Системные пакеты
sudo apt update && sudo apt upgrade -y
sudo snap refresh

# Docker
sudo apt update
sudo apt install --only-upgrade docker-ce docker-ce-cli containerd.io

# Kubernetes
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Oh My Zsh
omz update

# TUI инструменты
chezmoi upgrade
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
🚀 Рекомендации
После установки:
Перезагрузите систему для применения всех изменений

Настройте SSH ключи для Git

Импортируйте настройки в VS Code

Настройте UFW правила под свои нужды (см. configs/ufr-rules.example)

Лучшие практики:
Используйте chezmoi для управления dotfiles

Регулярно обновляйте систему

Настройте бэкапы важных данных

Используйте менеджер паролей

🐛 Устранение неполадок
См. docs/troubleshooting.md для решения распространенных проблем.

📝 Лицензия
MIT License - см. LICENSE файл.

**Примечание**: После создания всех файлов выполните:
```bash
chmod +x setup.sh scripts/*.sh