#!/bin/bash


#--------------------------------
# Declaración de funciones

# Función para mostrar la ayuda del script
function ayuda() {
  echo -e "\e[38;5;162mEste script sirve para ver los números comprendidos entre dos valores, no necesita argumentos"
  echo -e "Ejecución de ${0} pasando los números \e[38;5;117m10\e[0m \e[38;5;162my \e[38;5;117m20\e[0m"
  echo -e "\e[38;5;129mIntroduzca el primer número (si quiere finalizar introduzca el 99): \e[38;5;117m10\e[0m"
  echo -e "\e[38;5;129mIntroduzca el segundo número: \e[38;5;117m20\e[0m"
  echo -e "\e[38;5;117m10/20,  11/20,  12/20,  13/20,  14/20,  15/20,  16/20,  17/20,  18/20,  19/20,  20/20\e[0m"
}


# Función para indicar que hay un fallo en la petición de ayuda
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}