#!/bin/bash


#------------------------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función principal para la ayuda
function ayuda() {
  echo -e "\e[38;5;162mCon este script se generan datos al fichero de salida a través de los establecidos en el fichero de entrada"
  echo "Necesita dos argumentos, el primero es un fichero de entrada que debe existir y el segundo puede no existir\e[0m"
  echo -e "\e[38;5;129m${0} <fichero_entrada> <fichero_salida>\e[0m" && echo ""
  echo -e "\e[38;5;162mLa cabecera y los datos del fichero de entrada debe tener el siguiente formato:"
  echo -e "\e[1mNOMBRE;APELLIDOS;DNI"
  echo -e "Pepe;Perez;11111111A\e[0m"
}


# Función para indicar que hay un fallo en el argumento para la ayuda
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función que indica que el fichero de entrada no existe o no es un fichero de texto
function no_entrada() {
  echo -e "\e[38;5;196mEl script necesita que el fichero de entrada (primer argumento) exista y no sea un directorio"
  echo -e "También debe tener la siguiente estructura el fichero de entrada:\e[0m" && echo ""
  echo -e "\e[1;38;5;162mNOMBRE;APELLIDOS;DNI"
  echo -e "Pepe;Perez;11111111A\e[0m" && echo ""
  echo -e "\e[38;5;162mPuede ver la ayuda del script de la siguiente forma:\e[0m"
  echo -e "\e[38;5;129m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función que indica que no se ha pasado la cantidad de argumentos requerida
function wrong_args() {
  echo -e "\e[38;5;196mEl script necesita dos argumentos para su funcionamiento"
  echo -e "\e[38;5;129m${0} <fichero_entrada> <fichero_salida>\e[0m" && echo ""
  echo -e "\e[38;5;162mPuede ver la ayuda del script de la siguiente forma:\e[0m"
  echo -e "\e[38;5;129m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}