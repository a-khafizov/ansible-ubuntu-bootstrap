#!/bin/bash
set -e

echo "========================================="
echo "  Установка Docker и Kubernetes"
echo "========================================="

if ! command -v docker &> /dev/null; then
  sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  
  sudo usermod -aG docker $USER
  echo "⚠️  Перезайдите в систему для применения прав Docker"
fi

if ! command -v kubectl &> /dev/null; then
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
  
  echo 'source <(kubectl completion bash)' >> ~/.bashrc
  echo 'alias k="kubectl"' >> ~/.bashrc
  echo 'complete -F __start_kubectl k' >> ~/.bashrc
fi

if ! grep -q "alias d=" ~/.bashrc; then
  echo 'alias d="docker"' >> ~/.bashrc
  echo 'alias dc="docker compose"' >> ~/.bashrc
fi

echo ""
echo "✅ Docker установлен"
echo "✅ Kubernetes CLI установлен"
echo "✅ Алиасы добавлены: d, dc, k"