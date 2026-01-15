#!/bin/bash

echo "Генерация SSH ключа для GitHub..."

# Запрос email для генерации ключа
read -p "Введите email, указанный в GitHub: " github_email

# Генерация SSH ключа Ed25519 (рекомендуемый современный алгоритм)
ssh-keygen -t ed25519 -C "$github_email" -f ~/.ssh/id_ed25519

# Альтернатива для старых систем (если Ed25519 не поддерживается):
# ssh-keygen -t rsa -b 4096 -C "$github_email" -f ~/.ssh/id_rsa

# Запуск SSH-агента и добавление ключа
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519  # или ~/.ssh/id_rsa для RSA

# Создание конфигурации SSH если файла нет
if [ ! -f ~/.ssh/config ]; then
    cat > ~/.ssh/config << EOF
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519  # или ~/.ssh/id_rsa для RSA
    IdentitiesOnly yes
EOF
    chmod 600 ~/.ssh/config
fi

# Отображение публичного ключа
echo " "
echo "Публичный ключ для добавления в GitHub:"
echo "========================================"
cat ~/.ssh/id_ed25519.pub  # или ~/.ssh/id_rsa.pub для RSA
echo "========================================"
echo " "
echo "Скопируйте ключ выше и добавьте его в GitHub:"
echo "Settings -> SSH and GPG keys -> New SSH key"
echo " "
echo "Проверка подключения:"
ssh -T git@github.com