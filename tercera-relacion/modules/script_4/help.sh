#!/bin/bash


#-----------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda
function ayuda() {
  echo -e "\e[38;5;162mEste script lista el contenido del directorio en el que se ejecuta en formato CSV"
  echo -e "Hay que pasar mediante argumento un fichero que no tiene por qué existir para obtener el listado\e[0m"
  echo -e "\e[38;5;129m${0} <ruta/fichero>\e[0m"
}


# Función para indicar que no se han pasado argumentos
function no_arg() {
  echo -e "\e[38;5;196mPara hacer uso del script, tiene que pasar un argumento junto al script"
  echo -e "El argumento debe ser un fichero, que exista previamente o que no exista en el sistema\e[0m"
  echo -e "\e[38;5;129m${0} <ruta/fichero>\e[0m"
  exit 1
}