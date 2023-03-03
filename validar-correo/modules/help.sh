#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para explicar al usuario cómo funciona el script
function ayuda() {
  echo -e "\e[38;5;162mEste script se encarga de la validación de correos electrónicos"
  echo "Para hacer uso del script, pase un correo electrónico como argumento para hacer su validación:\e[0m"
  echo -e "\e[38;5;129m${0} <correo_electrónico>\e[0m"
}


# Función para indicar que no se han pasado la cantidad de argumentos requeridos
function error_arg() {
  echo -e "\e[38;5;196mNo ha pasado la cantidad de argumentos necesaria"
  echo -e "Debe pasar un único argumento:\e[0m"
  echo -e "\e[38;5;129m${0} <correo_electrónico>\e[0m"
  echo "" && echo -e "\e[38;5;162mPuede visualizar la ayuda con ${0} -h ó ${0} --help\e[0m"

}