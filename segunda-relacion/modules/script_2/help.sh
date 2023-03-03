#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función ayuda para script_2.sh
function ayuda() {
  echo -e "\e[38;5;162mEste script tiene varias funciones disponibles al ejecutarlo sin argumentos\e[0m" && echo ""
  menu_opciones
  exit 0
}

# Se muestra un aviso para el usuario de que puede necesitarse permisos de sudo
function aviso_sudo() {
  echo -e "\e[1;38;5;196mEste script puede necesitar permisos de sudo para que algunas funcionalidades se ejecuten correctamente"
  echo -e "\e[0m"
}