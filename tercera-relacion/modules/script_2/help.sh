#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

function ayuda() {
  echo -e "\e[38;5;162mEste script muestra el contenido de un fichero pasado por argumento, junto con la cantidad de líneas, palabras y caracteres"
  echo -e "Para hacer uso del script, debe pasar mediante un único argumento la ruta al fichero y su nombre\e[0m"
  echo -e "\e[38;5;129m${0} <ruta_fichero_nombre_fichero>"
  echo -e "${0} /home/usuario/cuentos.txt\e[0m"
}


# Función para indicar que no se ha pasado un argumento y que es necesario
function no_arg() {
  echo -e "\e[38;5;196mPara hacer uso del script, tiene que pasar un argumento, la ruta a un fichero\e[0m"
  echo -e "\e[38;5;129m${0} <ruta_fichero_nombre_fichero>\e[38;5;129m"
  echo -e "\e[38;5;226mPuede usar la ayuda del script de la siguiente forma:"
  echo -e "\e[38;5;129m${0} -h"
  echo -e "${0} --help\e[0m"
}