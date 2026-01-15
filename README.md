# Ubuntu Workstation Setup

## О проекте

Проект предоставляет набор Ansible плейбуков для автоматической установки и настройки всех необходимых инструментов для разработки на ОС Ubuntu. Проект помогает быстро настроить рабочую среду.

## Требования

- Ubuntu 22.04/24.04
- Ansible 2.13+

## Быстрый старт

1. Установите Ansible:
   ```bash
   sudo apt update
   sudo apt install -y ansible
   ```

2. Запустите настройку:
   ```bash
   ansible-playbook -i inventory.ini setup-workstation.yml -K
   ```

## Использование тегов

Вы можете запускать только определенные части конфигурации с помощью тегов:

```bash
# Установить только базовые утилиты
ansible-playbook -i inventory.ini setup-workstation.yml --tags "core" -K

# Установить среду разработки (ЯП)
ansible-playbook -i inventory.ini setup-workstation.yml --tags "dev" -K
```

Доступные теги:
- `core` - базовая настройка системы
- `dev` - настройка среды разработки
- `ide` - настройка VS Code

## Структура проекта

```
.
├── setup-workstation.yml     # Главный плейбук
├── ansible.cfg               # Конфигурационный файл Ansible
├── inventory.ini             # Инвентарь Ansible
├── group_vars/               # Глобальные переменные
│   └── all.yml              # Глобальные переменные для всех хостов
├── roles/                     # Роли Ansible
│   ├── core/                 # Базовая настройка системы
│   │   └── tasks/main.yml   # Задачи для роли core
│   ├── dev/                  # Среда разработки
│   │   └── tasks/main.yml    # Задачи для роли dev
│   └── vscode/               # Установка и настройка VS Code через APT
│       └── tasks/main.yml    # Задачи для роли vscode
├── scripts/                  # Вспомогательные скрипты
│   └── bash/                # Bash скрипты
│       ├── setup_git.sh     # Настройка Git
│       └── setup_ssh.sh    # Генерация SSH-ключей
└── docs/                     # Документация
    └── ansible-explanation.md # Как работает Ansible в этом проекте
```

## Документация

- [Как работает Ansible в этом проекте](docs/ansible-explanation.md)

## Лицензия

MIT