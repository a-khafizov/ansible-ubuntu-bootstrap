#!/bin/bash
set -e

# Функция для отображения справки
usage() {
    echo "Установка GoLang"
    echo "Использование: $0 [опции]"
    echo "Опции:"
    echo "  -v, --version VERSION  Установить конкретную версию Go (например, 1.21.0)"
    echo "  -h, --help            Показать эту справку"
    echo ""
    echo "Если версия не указана, будет установлена последняя стабильная версия."
}

# Параметры по умолчанию
GO_VERSION="latest"

# Обработка аргументов командной строки
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--version)
            GO_VERSION="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Неизвестный параметр: $1"
            usage
            exit 1
            ;;
    esac
done

echo "Установка GoLang"

# Проверка, установлен ли Go
if command -v go &> /dev/null; then
    INSTALLED_VERSION=$(go version | awk '{print $3}')
    echo "GoLang уже установлен: $INSTALLED_VERSION"
    
    # Спрашиваем, нужно ли переустановить
    read -p "Хотите переустановить Go? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Определение версии для установки
if [ "$GO_VERSION" = "latest" ]; then
    echo "Получение последней версии Go..."
        # Получаем последнюю версию Go, убирая лишние символы
        GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1 | tr -d '\n\r')
else
    # Проверяем, начинается ли версия с "go", если нет - добавляем
    if [[ $GO_VERSION != go* ]]; then
        GO_VERSION="go$GO_VERSION"
    fi
fi

echo "Установка версии: $GO_VERSION"

# Скачивание Go
ARCHIVE_NAME="${GO_VERSION}.linux-amd64.tar.gz"
wget "https://go.dev/dl/${ARCHIVE_NAME}"

# Распаковка в /usr/local
echo "Установка Go в /usr/local/go..."
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf ${ARCHIVE_NAME}

# Добавление Go в PATH (если еще не добавлено)
if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    echo "Go добавлен в PATH. Перезапустите терминал или выполните 'source ~/.bashrc'"
fi

# Добавление Go в PATH для zsh (если еще не добавлено)
if [ -f ~/.zshrc ]; then
    if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.zshrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
        echo "Go добавлен в PATH для zsh. Перезапустите терминал или выполните 'source ~/.zshrc'"
    fi
fi

# Удаление установочного файла
rm ${ARCHIVE_NAME}

# Проверка установки
if command -v go &> /dev/null; then
    INSTALLED_VERSION=$(go version)
    echo "GoLang успешно установлен: $INSTALLED_VERSION"
else
    # Принудительное обновление PATH для текущей сессии
    export PATH=$PATH:/usr/local/go/bin
    INSTALLED_VERSION=$(go version)
    echo "GoLang успешно установлен: $INSTALLED_VERSION"
fi