#!/bin/bash
set -e

echo "Установка инструментов для баз данных"

if ! command -v psql &> /dev/null; then
  echo "Установка PostgreSQL клиента..."
  sudo apt install -y postgresql-client
  echo "PostgreSQL клиент установлен"
else
  echo "PostgreSQL клиент уже установлен"
fi

if ! command -v dbeaver &> /dev/null; then
  echo "Установка DBeaver..."
  sudo snap install dbeaver-ce
  echo "DBeaver установлен"
else
  echo "DBeaver уже установлен"
fi

echo "Использование:"
echo "psql -h <хост> -U <пользователь> -d <база_данных>"
echo "dbeaver  # для запуска GUI"