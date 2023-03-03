#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script tiene varias funciones disponibles al ejecutarlo sin argumentos\e[0m" && echo ""
  opciones_disponibles
  exit 0
}

# Se muestra un aviso para el usuario de que puede necesitarse permisos de sudo
function aviso_sudo() {
  echo -e "\e[1;38;5;196mEste script puede necesitar permisos de sudo para que algunas funcionalidades se ejecuten correctamente\e[0m"
  echo ""
}
