#!/bin/bash
# Цвета
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
nc='\033[0m'

echo "----------------------------------------------------------"
echo "Скрипт для создания базовой структуры веб-разработки v0.0.6"
echo "----------------------------------------------------------"

echo "Обновление пакетов ... "
sudo apt update && sudo apt upgrade -y 
# Запрашиваем имя главной папки
read -p "Введите имя главной папки (по умолчанию project): " folder
folder=${folder:-project}

# Определяем структуру
styles="style"
javascript="script"
images="image"
inner_file1="$folder/index.html"
inner_file2="$folder/$styles/style.css"
inner_file3="$folder/$javascript/script.js"
outer_file="$folder/README.md"


# Проверяем существование папки и обоих файлов
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
            # После удаления создаём заново с тем же именем folder (повторно не спрашиваем)
            mkdir -p "$folder/$styles" "$folder/$javascript" "$folder/$images"
            touch "$inner_file1" "$inner_file2" "$inner_file3" "$outer_file"
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
     echo "  └── $outer_file (в текущем каталоге)"
     echo "===================================================="
     echo 'Создаём структуру каталогов и файлов...'
     echo 'Создан один отдельный  README.MD файл для инструкций...'
     mkdir -p "$folder/$styles" "$folder/$javascript" "$folder/$images"
     touch "$inner_file1" "$inner_file2" "$inner_file3" "$outer_file"
     echo -e "${green}Успешно все создано!${nc}"
fi





