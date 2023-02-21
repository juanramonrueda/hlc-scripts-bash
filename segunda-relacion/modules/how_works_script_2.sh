#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función para indicar la ayuda sobre el script de ejecución
function main() {
  echo -e "\e[38;5;177Para hacer uso del script, debe pasar dos argumentos; el primer argumento es un directorio y el segundo argumento un fichero de ese directorio" && echo ""
  echo -e "\e[1m${0} /home/usuario archivo.txt\e[0m"

  exit 1
}


#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función

main