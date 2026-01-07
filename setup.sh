#!/bin/bash
set -e

echo "========================================="
echo "  Ubuntu Developer Environment Setup"
echo "========================================="
echo ""
echo "Этот скрипт поможет установить всё необходимое окружение."
echo "Рекомендуется выполнять установку шаг за шагом."
echo ""
echo "Выберите действие:"
echo "1) Полная установка (не рекомендуется)"
echo "2) Пошаговая установка через отдельные скрипты"
echo "3) Проверка установленных инструментов"
echo "4) Выход"
echo ""
read -p "Ваш выбор [1-4]: " choice

case $choice in
  1)
    echo "Запуск полной установки..."
    for script in scripts/*.sh; do
      if [ -f "$script" ]; then
        echo "Выполнение: $(basename "$script")"
        bash "$script"
        echo ""
      fi
    done
    ;;
  2)
    echo "Доступные скрипты:"
    ls scripts/*.sh | nl
    echo ""
    read -p "Номер скрипта: " script_num
    scripts=($(ls scripts/*.sh))
    if [ -n "${scripts[$script_num-1]}" ]; then
      bash "${scripts[$script_num-1]}"
    else
      echo "Неверный номер!"
    fi
    ;;
  3)
    echo "=== Проверка установленных инструментов ==="
    tools=("code" "docker" "kubectl" "psql" "dbeaver" "postman" "insomnia" "openvpn" "zsh" "starship" "chezmoi" "lazygit" "lazydocker" "btop")
    for tool in "${tools[@]}"; do
      if command -v $tool >/dev/null 2>&1; then
        echo "✓ $tool"
      else
        echo "✗ $tool"
      fi
    done
    ;;
  4)
    echo "Выход."
    exit 0
    ;;
  *)
    echo "Неверный выбор!"
    exit 1
    ;;
esac

echo ""
echo "========================================="
echo "  Установка завершена!"
echo "  Подробности в README.md"
echo "========================================="