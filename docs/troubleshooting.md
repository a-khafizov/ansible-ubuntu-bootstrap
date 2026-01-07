markdown
# Устранение неполадок

## Docker

### Ошибка прав
```bash
sudo usermod -aG docker $USER
# Выйдите и войдите заново
Docker не запускается
bash
sudo systemctl start docker
sudo systemctl enable docker
Kubernetes
kubectl не работает
bash
# Переустановите
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
Сеть
UFW блокирует порты
bash
# Добавить правило
sudo ufw allow <port>/tcp

# Удалить правило
sudo ufw delete allow <port>/tcp
Терминал
Zsh не стал оболочкой по умолчанию
bash
chsh -s $(which zsh)
# Выйдите и войдите заново
Плагины не работают
bash
# Обновить Oh My Zsh
omz update

# Перезагрузить конфиг
source ~/.zshrc
Базы данных
Ошибка подключения psql
bash
# Проверить параметры подключения
psql -h <host> -p <port> -U <user> -d <database>

# Проверить доступность сервера
telnet <host> <port>
Общие проблемы
Ошибки apt
bash
sudo apt clean
sudo apt autoclean
sudo apt autoremove
sudo dpkg --configure -a
Недостаточно места
bash
# Очистка старых ядер
sudo apt autoremove --purge

# Очистка Docker
docker system prune -a