#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para mostrar la ayuda para script_1.sh
function ayuda() {
  echo -e "\e[38;5;162mEste script realiza las operaciones matemáticas sencillas"
  echo -e "\e[1mSuma ---> +"
  echo "Resta ---> -"
  echo "Multiplicación ---> \*"
  echo "División y obtención de cociente ---> /"
  echo -e "División y obtención de módulo (resto) ---> %\e[0m"
  echo ""
  echo -e "\e[38;5;162mPara ello, hay que pasar los valores y el operando mediante argumento en el siguiente orden:"
  echo -e "\e[1m${0} 4.5 -5 \*\e[0m"
  echo -e "\e[38;5;162mSe pueden pasar números positivos, negativos y decimales para las operaciones\e[0m"

}


# Función que indica que no ha pasado ningún argumento al script y salida con código de error
function no_arg() {
  echo -e "\e[38;5;196mPara hacer uso del script, tiene que pasar tres argumentos junto al script (sin <>)\e[0m"
  echo -e "\e[38;5;129m${0} <número> <número> <operador_matemático>\e[0m"
  echo -e "\e[38;5;196mPudiendo ser los operadores ---> + (suma) ; - (resta) ; \* (multiplicación) ; / (división cociente) ; % (división resto)\e[0m"
  exit 1
}


# Función para indicar que hay un problema en la división y salida con código de error
function error_division() {
  echo -e "\e[38;5;196mSi desea realizar la división de ${PRIMER_ARGUMENTO} entre ${SEGUNDO_ARGUMENTO}, el segundo argumento tiene que ser distinto de 0"
  echo -e "Finalizando la ejecución...\e[0m"
  exit 1
}