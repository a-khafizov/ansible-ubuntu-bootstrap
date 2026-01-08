#!/bin/bash
set -e

echo "Установка Docker и Kubernetes"

if ! command -v docker &> /dev/null; then
  echo "Установка Docker..."
  sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  
  sudo usermod -aG docker $USER
  echo "Перезайдите в систему для применения прав Docker"
else
  echo "Docker уже установлен"
fi

if ! command -v kubectl &> /dev/null; then
  echo "Установка kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
else
  echo "kubectl уже установлен"
fi

if ! grep -q "alias d=" ~/.bashrc; then
  echo 'alias d="docker"' >> ~/.bashrc
  echo 'alias dc="docker compose"' >> ~/.bashrc
  echo 'alias k="kubectl"' >> ~/.bashrc
fi

if ! grep -q "kubectl completion" ~/.bashrc; then
  echo 'source <(kubectl completion bash)' >> ~/.bashrc
  echo 'complete -F __start_kubectl k' >> ~/.bashrc
fi

echo "Docker установлен"
echo "Kubernetes CLI установлен"
echo "Алиасы добавлены: d, dc, k"