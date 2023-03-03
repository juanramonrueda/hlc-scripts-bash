#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para indicar la ayuda sobre el script de ejecución
function ayuda() {
  echo -e "\e[38;5;177mPara hacer uso del script debe pasar dos argumentos, el primer argumento es un directorio y el segundo argumento un fichero de ese directorio"
  echo -e "\e[1m${0} /home/usuario archivo.txt\e[0m"
}


# Función para indicar que hay un fallo en el argumento para la ayuda
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}