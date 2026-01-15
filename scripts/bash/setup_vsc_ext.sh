#!/bin/bash

# Список расширений для установки (по одному на строку)
EXTENSIONS=(
  "doggy8088.go-extension-pack"
  "eamodio.gitlens"
  "ms-ceintl.vscode-language-pack-ru"
  "ms-kubernetes-tools.vscode-kubernetes-tools"
  "redhat.vscode-xml"
  "redhat.vscode-yaml"
  "drblury.protobuf-vsc"
  "ms-vscode-remote.remote-containers"
  "formulahendry.docker-extension-pack"
)

# Переменные для статистики
TOTAL=${#EXTENSIONS[@]}
INSTALLED=0
FAILED=0

echo "📦 Всего расширений для установки: $TOTAL"
echo "⏳ Начинаем установку..."
echo "---"

# Цикл по списку расширений
for ext in "${EXTENSIONS[@]}"; do
  echo -n "🔧 Устанавливаем $ext... "

  # Попытка установки
  if code --install-extension "$ext" &> /dev/null; then
    echo "✓ УСПЕХ"
    ((INSTALLED++))
  else
    echo "✗ ОШИБКА"
    ((FAILED++))
  fi
done

# Итоговый отчёт
echo "---"
echo "✅ Установлено: $INSTALLED"
echo "❌ Не удалось: $FAILED"
echo "🎯 Осталось: $((TOTAL - INSTALLED - FAILED))"
echo "🎉 Готово!"
