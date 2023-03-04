#!/bin/bash


#-----------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script necesita un directorio pasado por argumento para pedir posiciones y mostrar el archivo en esa posición\e[0m"
  echo -e "\e[38;5;129m${0} <ruta_directorio>"
  echo -e "${0} /home/usuario\e[0m"
}


# Función para indicar que hay un fallo en cuanto a los argumentos
function no_arg() {
  echo -e "\e[38;5;196mPara hacer uso del script, debe pasar mediante argumento un directorio del sistema\e[0m"
  echo -e "\e[38;5;129m${0} <ruta_directorio>"
  echo -e "${0} /home/usuario\e[0m"
  exit 1
}