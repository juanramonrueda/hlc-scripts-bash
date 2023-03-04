#!/bin/bash


#--------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script tiene varias funciones disponibles al ejecutarlo, no necesita argumentos" 
  echo ""
  
  # Se muestran las opciones disponibles
  opciones_disponibles
  
  # Aviso para la ejecución correcta del script
  echo "" && aviso_sudo
  
  # Salida de la ejecución del script
  exit 0
}


# Función para indicar que hay un fallo en el argumento para la ayuda
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Se muestra un aviso para el usuario de que puede necesitarse permisos de sudo
function aviso_sudo() {
  echo -e "\e[1;38;5;196mEste script puede necesitar permisos de sudo para que algunas funcionalidades se ejecuten correctamente\e[0m"
  echo ""
}