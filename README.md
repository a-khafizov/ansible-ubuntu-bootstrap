# dev-env-ansible

Современная Ansible-реализация для настройки рабочего окружения разработчика.

## О проекте

Этот проект предоставляет идемпотентную конфигурацию рабочего окружения разработчика с использованием Ansible. 
Он заменяет устаревшие bash-скрипты более надежным и управляемым подходом.

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

# Установить CLI инструменты и среду разработки
ansible-playbook -i inventory.ini setup-workstation.yml --tags "cli,dev" -K
```

Доступные теги:
- `core` - базовая настройка системы
- `cli` - установка CLI утилит
- `dev` - настройка среды разработки
- `desktop` - установка графических приложений
- `ide` - настройка VS Code

## Структура проекта

```
.
├── setup-workstation.yml     # Главный плейбук
├── inventory.ini             # Инвентарь Ansible
├── group_vars/all.yml        # Глобальные переменные
├── roles/                    # Роли Ansible
│   ├── core/                 # Базовая настройка системы
│   ├── cli-tools/            # CLI утилиты
│   ├── dev-env/             # Среда разработки
│   ├── desktop-apps/        # Графические приложения
│   └── ide-config/           # Настройка VS Code
└── legacy-bash/             # Устаревшие bash-скрипты (для истории)
```

## Документация

- [Документация по ролям и переменным](docs/roles.md) (будет добавлена позже)

## Устаревшая версия

Оригинальные bash-скрипты доступны в директории [legacy-bash/](legacy-bash/) для истории и справки.

## Лицензия

MIT