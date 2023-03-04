#!/bin/bash


#---------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función que muestra la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script calcula la siguiente ecuación pidiendo un valor para 'x'\e[0m"
  echo -e "\e[38;5;129m3x² + 5x + 8\e[0m"
}


# Función para indicar que hay un error en la petición de ayuda
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función para indicar que no han de pasarse argumentos junto al script
function no_args() {
  echo -e "\e[38;5;196mEl script no necesita argumentos para ejecutarse"
  exit 1
}


# Función para indicar que hay un error en la introducción del valor a la variable X
function error_variable() {
  echo -e "\e[38;5;196mLa variable 'x' no es un número, introduzca únicamente números reales\e[0m"
  exit 1
}