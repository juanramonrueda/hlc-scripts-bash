#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda con respecto al script
function ayuda() {
  echo -e "\e[38;5;162mEste script se encarga de comparar dos ficheros, los dos primeros ficheros se comparan, la salida es por pantalla y al tercer fichero"
  echo -e "\e[38;5;129m${0} <ruta/fichero_a_comparar> <ruta/fichero_a_comparar> <ruta/fichero_comparacion>\e[0m"
}


#
function error_ayuda() {
  echo -e "\e[38;5;196mSe ha equivocado de argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1

}


#
function wrong_args() {
  echo -e "\e[38;5;196mPara hacer uso del script, tiene que pasar tres argumentos junto al script"
  echo -e "Los dos primeros argumentos son ficheros para compararlos y tienen que existir, el tercer argumento es un fichero de comparación que puede no existir\e[0m"
  echo -e "\e[38;5;129m${0} <ruta/fichero> <ruta/fichero> <ruta/fichero>\e[0m"
  exit 1
}