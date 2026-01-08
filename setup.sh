#!/bin/bash

# Скрипт для настройки среды разработки на Ubuntu
# Версия: 1.0
# Автор: developer-setup-ubuntu

set -e  # Завершить выполнение при первой ошибке

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Пути к скриптам
SCRIPTS_DIR="./scripts"
LOG_FILE="./setup.log"

# Функция для вывода сообщений с цветом
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Функция для логирования
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ${message}" >> "${LOG_FILE}"
}

# Функция для вывода заголовка
print_header() {
    local title=$1
    echo
    print_message "${BLUE}" "=========================================="
    print_message "${BLUE}" "${title}"
    print_message "${BLUE}" "=========================================="
    echo
}

# Функция для проверки совместимости системы
check_compatibility() {
    print_header "Проверка совместимости"
    
    # Проверка ОС
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "$ID" != "ubuntu" ]]; then
            print_message "${YELLOW}" "Предупреждение: Скрипт предназначен для Ubuntu. Текущая ОС: $ID"
        else
            print_message "${GREEN}" "Операционная система: $NAME $VERSION"
        fi
    else
        print_message "${YELLOW}" "Предупреждение: Не удалось определить операционную систему"
    fi
    
    # Проверка архитектуры
    local arch=$(uname -m)
    print_message "${GREEN}" "Архитектура: $arch"
    
    # Проверка наличия sudo
    if ! command -v sudo &> /dev/null; then
        print_message "${RED}" "Ошибка: Не найдена команда sudo. Установите sudo для продолжения."
        exit 1
    fi
    
    print_message "${GREEN}" "Проверка совместимости завершена успешно"
    log_message "Проверка совместимости завершена"
}

# Функция для отображения меню
show_menu() {
    echo
    print_message "${BLUE}" "Выберите действие:"
    echo "  1) Установить все компоненты"
    echo "  2) Установить базовые утилиты"
    echo "  3) Установить VS Code"
    echo "  4) Настроить Git"
    echo "  5) Установить инструменты для БД"
    echo "  6) Установить Docker и Kubernetes"
    echo "  7) Настроить безопасность (UFW)"
    echo "  8) Установить кастомные инструменты"
    echo "  9) Настроить терминал (Zsh)"
    echo " 10) Установить Яндекс Браузер"
    echo " 11) Установить GoLang"
    echo "  0) Выйти"
    echo
}

# Функция для выполнения скрипта с логированием
run_script() {
    local script_name=$1
    local description=$2
    
    if [[ -f "${SCRIPTS_DIR}/${script_name}" ]]; then
        print_header "Установка: ${description}"
        log_message "Запуск скрипта: ${script_name}"
        
        if bash "${SCRIPTS_DIR}/${script_name}"; then
            print_message "${GREEN}" "✓ ${description} успешно установлен"
            log_message "Скрипт ${script_name} выполнен успешно"
        else
            print_message "${RED}" "✗ Ошибка при установке ${description}"
            log_message "Ошибка при выполнении скрипта: ${script_name}"
            return 1
        fi
    else
        print_message "${YELLOW}" "Файл скрипта не найден: ${script_name}"
        log_message "Файл скрипта не найден: ${script_name}"
    fi
}

# Функция для установки всех компонентов
install_all() {
    print_header "Установка всех компонентов"
    
    run_script "01-install-basic-tools.sh" "Базовые утилиты" || return 1
    run_script "02-install_vscode.sh" "VS Code" || return 1
    run_script "03-config-git.sh" "Настройка Git" || return 1
    run_script "04-install-db-tools.sh" "Инструменты для БД" || return 1
    run_script "05-install-docker-k8s.sh" "Docker и Kubernetes" || return 1
    run_script "06-install-security.sh" "Безопасность (UFW)" || return 1
    run_script "07-install-custom-tools.sh" "Кастомные инструменты" || return 1
    run_script "08-install-zsh.sh" "Терминал (Zsh)" || return 1
    run_script "09-install-yandex-browser.sh" "Яндекс Браузер" || return 1
    run_script "10-install-golang.sh" "GoLang" || return 1
    
    print_header "Все компоненты успешно установлены!"
    print_message "${GREEN}" "Для применения некоторых изменений может потребоваться перезагрузка системы или выход из учетной записи."
}

# Функция для установки отдельных компонентов
install_component() {
    local choice=$1
    
    case $choice in
        1)
            install_all
            ;;
        2)
            run_script "01-install-basic-tools.sh" "Базовые утилиты"
            ;;
        3)
            run_script "02-install_vscode.sh" "VS Code"
            ;;
        4)
            run_script "03-config-git.sh" "Настройка Git"
            ;;
        5)
            run_script "04-install-db-tools.sh" "Инструменты для БД"
            ;;
        6)
            run_script "05-install-docker-k8s.sh" "Docker и Kubernetes"
            ;;
        7)
            run_script "06-install-security.sh" "Безопасность (UFW)"
            ;;
        8)
            run_script "07-install-custom-tools.sh" "Кастомные инструменты"
            ;;
        9)
            run_script "08-install-zsh.sh" "Терминал (Zsh)"
            ;;
        10)
            run_script "09-install-yandex-browser.sh" "Яндекс Браузер"
            ;;
        11)
            run_script "10-install-golang.sh" "GoLang"
            ;;
        *)
            print_message "${YELLOW}" "Неверный выбор"
            ;;
    esac
}

# Основная функция
main() {
    # Очистка лога при запуске
    > "${LOG_FILE}"
    
    print_header "Настройка среды разработки Ubuntu"
    print_message "${GREEN}" "Добро пожаловать в скрипт автоматической настройки среды разработки!"
    
    # Проверка совместимости
    check_compatibility
    
    # Основной цикл меню
    while true; do
        show_menu
        read -p "Введите номер действия: " choice
        
        case $choice in
            0)
                print_message "${GREEN}" "Спасибо за использование скрипта! До свидания."
                exit 0
                ;;
            [0-9]|1[0-1])
                install_component $choice
                echo
                read -p "Нажмите Enter для продолжения..."
                ;;
            *)
                print_message "${YELLOW}" "Неверный выбор. Пожалуйста, введите число от 0 до 11."
                ;;
        esac
    done
}

# Запуск основной функции
main "$@"