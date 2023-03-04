#!/bin/bash


#----------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script realiza operaciones sobre un fichero de texto pasado por argumento"
  echo -e "Se ha de pasar un fichero de texto y se generarán cuatro ficheros con sus respectivas operaciones\e[0m"
  echo -e "\e[38;5;129m${0} <fichero_texto>\e[0m" && echo ""
  echo -e "\e[38;5;162mLas operaciones que se realizarán son:"
  echo "Conversión del texto a minúsculas"
  echo "Conversión del texto a mayúsculas"
  echo "Supresión de todas las letras a / A del texto"
  echo -e "Conversión de todas las vocales a mayúsculas\e[0m"
}


# Función para indicar que se han pasado más argumentos de los necesarios
function wrong_args() {
  echo -e "\e[38;5;196mEl script únicamente necesita un argumento:\e[0m"
  echo -e "\e[38;5;129m${0} <fichero_texto>\e[0m"
  exit 1
}


# Función que indica que no se ha pasado un directorio en el argumento
function error_arg() {
  echo -e "\e[38;5;196mEl argumento pasado, ${FICHERO_ENTRADA}, no es un fichero de texto\e[0m"
  exit 1
}