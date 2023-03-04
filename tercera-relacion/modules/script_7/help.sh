#!/bin/bash


#---------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script muestra un mensaje en función de la hora del sistema\e[0m"
}


# Función para indicar que hay un error en la petición de ayuda del script
function error_ayuda() {
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función para indicar que el script no necesita ningún argumento para su ejecución
function no_args() {
  echo -e "\e[1;38;5;196mEl script no necesita argumentos para su funcionamiento\e[0m"
  exit 1
}