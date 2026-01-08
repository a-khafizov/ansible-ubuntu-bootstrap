#!/bin/bash
set -e

echo "Установка базовых системных утилит"

sudo apt update && sudo apt upgrade -y

# Важные системные пакеты
echo "Установка системных пакетов..."
sudo apt install -y curl wget git build-essential software-properties-common apt-transport-https ca-certificates gnupg lsb-release unzip zip net-tools openvpn network-manager-openvpn-gnome

# Утилиты мониторинга и работы с системой
echo "Установка утилит мониторинга..."
sudo apt install -y htop btop ncdu nethogs tree

# CLI инструменты (доступные через apt)
echo "Установка CLI инструментов..."
sudo apt install -y fzf ripgrep bat fd-find jq yq

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