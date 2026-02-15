#!/bin/bash

# Цвета
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
nc='\033[0m' # No Color

# Функция вывода справки
show_help() {
    cat << EOF
Использование: $0 [опции] [имя_папки]

Опции:
  -h, --help      показать эту справку

Если имя_папки не указано, скрипт запросит его интерактивно.
Примеры:
  $0 myproject
EOF
    exit 0
}

# Обработка аргументов (если нужно)
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) show_help ;;
        *) echo "Неизвестный аргумент: $1"; show_help ;;
    esac
done

# Главная функция
main() {
    echo "----------------------------------------------------------"
    echo "Скрипт для создания базовой структуры веб-разработки v0.0.7"
    echo "----------------------------------------------------------"

    # Запрашиваем имя главной папки
    read -p "Введите имя главной папки (по умолчанию project): " folder
    folder=${folder:-project}

    # Определяем структуру ПОСЛЕ того, как folder известна
    styles="style"
    javascript="script"
    images="image"
    inner_file1="$folder/index.html"
    inner_file2="$folder/$styles/style.css"
    inner_file3="$folder/$javascript/script.js"
    outer_file="$folder/README.md"

    # Функция создания структуры (папки и пустые файлы)
    create_structure() {
        mkdir -p "$folder/$styles" "$folder/$javascript" "$folder/$images"
        touch "$inner_file1" "$inner_file2" "$inner_file3" "$outer_file"
        echo 'Создана структура каталогов и файлов.'
    }

    # Проверяем существование папки и всех файлов
    if [ -d "$folder" ] && [ -d "$folder/$images" ] && [ -f "$inner_file1" ] && [ -f "$inner_file2" ] && [ -f "$inner_file3" ] && [ -f "$outer_file" ]; then
        echo -e "${red}Всё уже существует:${nc}"
        echo -e "${red}  Папка '$folder'${nc}"
        echo -e "${red}  Папка '$folder/$images'${nc}"
        echo -e "${red}  Файл '$inner_file1'${nc}"
        echo -e "${red}  Файл '$inner_file2'${nc}"
        echo -e "${red}  Файл '$inner_file3'${nc}"
        echo -e "${red}  Файл '$outer_file'${nc}"
        echo
        read -p "Хотите удалить всё и создать заново? (y/n): " answer
        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            echo "Удаляем существующую папку '$folder' (будьте внимательны)..."
            rm -ri "$folder"
            if [ $? -eq 0 ]; then
                create_structure
                echo -e "${green}Готово! Структура создана заново.${nc}"
            else
                echo -e "${red}Удаление отменено или не удалось. Новая структура не создана.${nc}"
            fi
        else
            echo "Операция отменена."
        fi
    else
        echo "===================================================="
        echo -e "${yellow}Будет создана структура:${nc}"
        echo "  $folder/"
        echo "  ├── $images/"
        echo "  ├── $styles/"
        echo "  │   └── style.css"
        echo "  ├── $javascript/"
        echo "  │   └── script.js"
        echo "  ├── index.html"
        echo "  └── README.md (в папке $folder)"
        echo "===================================================="
        create_structure
        echo -e "${green}Успешно всё создано!${nc}"
    fi
}

# Запуск
main
