#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para indicar la ayuda sobre el script de ejecución
function ayuda() {
  echo -e "\e[38;5;162mEste script sirve para comprobar si un fichero existe en una ruta y mostrar su contenido en caso afirmativo"
  echo -e "Para hacer uso del script debe pasar dos argumentos, el primer argumento es un directorio y el segundo argumento un fichero de ese directorio, ambos sin <>\e[0m"
  echo "" && echo -e "\e[38;5;129m${0} <ruta_directorio> <archivo_del_directorio>\e[0m"
}


# Función para indicar que hay un fallo en el argumento para la ayuda
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función para indicar que no se ha pasado ningún argumento
function no_arg() {
  echo -e "\e[38;5;196mPara hacer uso del script, tiene que pasar dos argumentos junto al script (sin <>)"
  echo -e "El primer argumento es un directorio y el segundo un fichero de ese directorio para ver el contenido del fichero\e[0m"
  echo -e "\e[38;5;129m${0} <ruta_directorio> <archivo_del_directorio>\e[0m"
  exit 1
}
