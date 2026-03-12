# Ansible Ubuntu Bootstrap

## О проекте

Проект помогает быстро настроить рабочую среду.

## Требования

- Ubuntu 22.04/24.04
- Ansible 2.13+

## Быстрый старт

1. Установите Ansible:
   ```bash
   sudo apt update
   sudo apt install -y ansible
   ```

2. Запустите настройку (инвентарь по умолчанию использует `localhost`):
   ```bash
   ansible-playbook -i inventory.ini setup.yml -K
   ```
   Флаг `-K` запросит пароль sudo для выполнения задач с повышенными привилегиями.

## Использование тегов

Вы можете запускать только определённые части конфигурации с помощью тегов:

```bash
# Установить только базовые утилиты
ansible-playbook -i inventory.ini setup.yml --tags "core" -K

# Установить среду разработки (языки программирования, Docker, kubectl)
ansible-playbook -i inventory.ini setup.yml --tags "dev" -K
```

Доступные теги:
- `core` – базовая настройка системы (обновление пакетов, установка утилит, алиасы)
- `dev` – настройка среды разработки (Python, Node.js, Java, Go, Docker, kubectl)

## Управление установкой через переменные

В файле `group_vars/all.yml` можно отключить определённые компоненты, изменив булевы переменные:

```yaml
install_core: true          # устанавливать базовые утилиты (роль core)
install_dev_env: true       # устанавливать среду разработки (роль dev)
```

Если переменная установлена в `false`, соответствующая роль будет пропущена.

## Проверка изменений (dry‑run)

Перед реальным выполнением рекомендуется проверить, какие изменения будут внесены:

```bash
ansible-playbook -i inventory.ini setup.yml --check --diff -K
```

## Структура проекта

```
.
├── setup.yml               # Главный плейбук
├── ansible.cfg             # Конфигурационный файл Ansible
├── inventory.ini           # Инвентарь Ansible (localhost)
├── group_vars/             # Глобальные переменные
│   └── all.yml            # Глобальные переменные для всех хостов
├── roles/                  # Роли Ansible
│   ├── core/              # Базовая настройка системы
│   │   └── tasks/main.yml # Задачи для роли core
│   ├── dev/               # Среда разработки
│   │   └── tasks/main.yml # Задачи для роли dev
└── scripts/                # Вспомогательные скрипты
    └── bash/              # Bash скрипты
        └── setup_git.sh   # Настройка Git (альтернативный способ)
```

## Лицензия

MIT
