#!/bin/bash


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script muestra información sobre el usuario que ejecuta el script, su nombre, directorio de trabajo y Shell asociada\e[0m"
}


# Función para indicar que hay un fallo en la petición de la ayuda del script
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función para indicar que el script no necesita argumentos para su ejecución
function no_args() {
  echo -e "\e[1;38;5;196mEste script no necesita argumentos para su ejecución\e[0m"
  exit 1
}