#!/bin/bash

# Список расширений для установки (по одному на строку)
EXTENSIONS=(
  "adamhartford.vscode-base64"
  "doggy8088.go-extension-pack"
  "dotjoshjohnson.xml"
  "eamodio.gitlens"
  "formulahendry.code-runner"
  "golang.go"
  "hayden.extension-pack-manager"
  "ms-azuretools.vscode-containers"
  "ms-ceintl.vscode-language-pack-ru"
  "ms-kubernetes-tools.vscode-kubernetes-tools"
  "ms-vscode-remote.remote-containers"
  "ms-vscode-remote.remote-wsl"
  "nhoizey.gremlins"
  "premparihar.gotestexplorer"
  "quicktype.quicktype"
  "redhat.vscode-xml"
  "redhat.vscode-yaml"
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
