#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script tiene varias funciones disponibles al ejecutarlo sin argumentos\e[0m" && echo ""
  opciones_disponibles
  exit 0
}
