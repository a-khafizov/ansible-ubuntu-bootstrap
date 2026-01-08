#!/bin/bash
set -e

echo "Установка базовых системных утилит"

sudo apt update && sudo apt upgrade -y

# Важные системные пакеты
sudo apt install -y \
  curl \          # Загрузка файлов из интернета
  wget \          # Альтернатива curl для загрузки
  git \           # Система контроля версий
  build-essential \ # Компиляторы и инструменты для сборки
  software-properties-common \ # Управление репозиториями
  apt-transport-https \ # Поддержка HTTPS для apt
  ca-certificates \ # Сертификаты для безопасных соединений
  gnupg \         # Шифрование и подписи пакетов
  lsb-release \   # Информация о версии ОС
  unzip \         # Распаковка ZIP архивов
  zip \           # Создание ZIP архивов
  net-tools       # Сетевые утилиты (ifconfig, netstat и др.)

# Утилиты мониторинга и работы с системой
sudo apt install -y \
  htop \          # Интерактивный мониторинг процессов
  btop \          # Продвинутый мониторинг с графикой
  ncdu \          # Анализ использования диска
  nethogs \       # Мониторинг сетевого трафика по процессам
  tree            # Дерево каталогов

# CLI инструменты (доступные через apt)
sudo apt install -y \
  fzf \           # Fuzzy finder для быстрого поиска
  ripgrep \       # Быстрый поиск по содержимому файлов
  bat \           # Просмотр файлов с подсветкой синтаксиса
  fd-find \       # Удобный поиск файлов
  jq \            # Обработка JSON
  yq              # Обработка YAML

# Симлинки для удобства (batcat -> bat, fdfind -> fd)
if [ -f /usr/bin/batcat ] && [ ! -f /usr/bin/bat ]; then
  sudo ln -s /usr/bin/batcat /usr/bin/bat
fi

if [ -f /usr/bin/fdfind ] && [ ! -f /usr/bin/fd ]; then
  sudo ln -s /usr/bin/fdfind /usr/bin/fd
fi

echo "Базовые утилиты установлены"
echo ""
echo "Доступные команды:"
echo "  htop, btop  - мониторинг системы"
echo "  ncdu        - анализ дискового пространства"
echo "  tree        - дерево каталогов"
echo "  fzf         - интеллектуальный поиск"
echo "  rg (ripgrep) - быстрый поиск по файлам"
echo "  bat         - cat с подсветкой"
echo "  fd          - поиск файлов"
echo "  jq, yq      - обработка JSON/YAML"