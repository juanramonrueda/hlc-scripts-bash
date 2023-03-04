#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script entra en un bucle infinito que pide pulsaciones de tecla hasta que se pulse Intro"
  echo -e "No necesita argumentos para su ejecución normal\e[0m"
}


# Función que avisa de un error en la petición de ayuda del script
function error_ayuda() {
  echo -e "Hola?"
  exit 1
}


# Función para indicar que no necesita argumentos
function no_args() {
  echo -e "\e[38;5;196mEste script no necesita argumentos\e[0m"
  exit 1
}