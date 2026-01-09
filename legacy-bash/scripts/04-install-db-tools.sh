#!/bin/bash
set -e

echo "Установка инструментов для баз данных"

if ! command -v psql &> /dev/null; then
    sudo apt install -y postgresql-client
fi

if ! command -v dbeaver &> /dev/null; then
    sudo snap install dbeaver-ce --classic
fi

echo "Инструменты для баз данных установлены"
echo "psql     - CLI клиент PostgreSQL"
echo "dbeaver  - GUI для работы с различными БД"