#!/bin/bash
set -e

echo "========================================="
echo "  Установка инструментов для баз данных"
echo "========================================="

if ! command -v psql &> /dev/null; then
  sudo apt install -y postgresql-client
  echo "✅ PostgreSQL клиент установлен"
else
  echo "✅ PostgreSQL клиент уже установлен"
fi

if ! command -v dbeaver &> /dev/null; then
  sudo snap install dbeaver-ce
  echo "✅ DBeaver установлен"
else
  echo "✅ DBeaver уже установлен"
fi

echo ""
echo "Использование:"
echo "  psql -h <хост> -U <пользователь> -d <база_данных>"
echo "  dbeaver  # для запуска GUI"