#!/bin/bash


#------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función principal para la ayuda
function main() {
  echo -e "\e[38;5;160mEste script necesita dos argumentos, el primero es un fichero de entrada que debe existir y el segundo puede no existir"
  echo "Con este script se generan datos al fichero de salida a través de los establecidos en el fichero de entrada"
  echo "La cabecera y los del fichero de entrada debe ser la siguiente:"
  echo -e "\e[1mNOMBRE;APELLIDOS;DNI"
  echo -e "Pepe;Perez;11111111A\e[0m"
}


#------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

main