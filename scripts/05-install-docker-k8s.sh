#!/bin/bash
set -e

echo "Установка Docker и Kubernetes"

# Установка Docker CE с официального репозитория
if ! command -v docker &> /dev/null; then
    sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
    
    # Добавление GPG ключа Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    # Добавление репозитория Docker в sources.list
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    
    sudo usermod -aG docker $USER
    echo "Перезайдите в систему для применения прав Docker"
fi

# Установка kubectl (CLI для Kubernetes)
if ! command -v kubectl &> /dev/null; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
fi

# Добавление алиасов для быстрого доступа
if ! grep -q "alias d=" ~/.bashrc; then
    echo 'alias d="docker"' >> ~/.bashrc       # Алиас для docker
    echo 'alias dc="docker compose"' >> ~/.bashrc  # Алиас для docker compose
    echo 'alias k="kubectl"' >> ~/.bashrc      # Алиас для kubectl
fi

# Включение автодополнения для kubectl
if ! grep -q "kubectl completion" ~/.bashrc; then
    echo 'source <(kubectl completion bash)' >> ~/.bashrc  # Bash completion
    echo 'complete -F __start_kubectl k' >> ~/.bashrc      # Completion для алиаса k
fi

echo "Docker и Kubernetes установлены"
echo "Алиасы: d=docker, dc=docker compose, k=kubectl"