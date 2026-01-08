# Устранение неполадок

## Общие проблемы

### Ошибки apt
```bash
# Очистка кеша
sudo apt clean
sudo apt autoclean
sudo apt autoremove

# Восстановление пакетов
sudo dpkg --configure -a
sudo apt install -f
Недостаточно места на диске
```bash
# Очистка старых ядер
sudo apt autoremove --purge

# Очистка кеша Docker
docker system prune -a

# Очистка журналов
sudo journalctl --vacuum-time=7d
```

### Docker

#### Ошибка: "Got permission denied"
```bash
# Добавить пользователя в группу docker
sudo usermod -aG docker $USER
# Проверить группы
groups $USER
# Перезагрузить систему или выйти/войти
Docker не запускается
```bash
# Проверить статус
sudo systemctl status docker
# Запустить
sudo systemctl start docker
sudo systemctl enable docker
```

### Взаимодействие Docker и UFW

Docker может обходить правила UFW. Для контроля используйте:

Ограничивайте порты на уровне контейнера: `-p 127.0.0.1:8080:8080`

Используйте решение: https://github.com/chaifeng/ufw-docker

### Kubernetes

#### kubectl не работает
```bash
# Проверить версию
kubectl version --client
# Проверить конфиг
ls -la ~/.kube/config
```
### Сеть

#### OpenVPN подключение
```bash
# Установка клиента
sudo apt install -y openvpn network-manager-openvpn network-manager-openvpn-gnome
```

# Использование .ovpn файла:
# 1. Через GUI: Настройки сети → VPN → Добавить → Импорт из файла...
# 2. Через терминал:
nmcli connection import type openvpn file /путь/к/файлу.ovpn

#### UFW блокирует нужные порты
```bash
# Добавить правило
sudo ufw allow <port>/tcp
# Или для конкретного IP
sudo ufw allow from <ip> to any port <port>
# Удалить правило
sudo ufw delete allow <port>/tcp
```
### Терминал

#### Zsh не стал оболочкой по умолчанию
```bash
# Сменить оболочку
chsh -s $(which zsh)
# Проверить текущую оболочку
echo $SHELL
```

#### Плагины Oh My Zsh не работают
```bash
# Обновить Oh My Zsh
omz update
# Перезагрузить конфиг
source ~/.zshrc
```
### Базы данных

#### Ошибка подключения psql
```bash
# Проверить параметры
psql -h <host> -p <port> -U <user> -d <database>
# Проверить доступность сервера
telnet <host> <port>
```

#### DBeaver не запускается
```bash
# Проверить установку
snap list | grep dbeaver
# Переустановить
sudo snap remove dbeaver-ce
sudo snap install dbeaver-ce
```
### VS Code

#### Не запускается из терминала
```bash
# Переустановить через snap
sudo snap remove code
sudo snap install --classic code
# Или добавить в PATH
sudo ln -s /usr/share/code/bin/code /usr/local/bin/code
```