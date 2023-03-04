#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función principal para indicar cómo funciona el script
function ayuda() {
  echo -e "\e[38;5;162mEste script tiene la función de comprobar los hosts activos en la red"
  echo -e "Para usar el script, tiene que pasar una dirección de red, de broadcast o una IP de host como argumento:\e[0m"
  echo -e "\e[38;5;129m${0} <ip>\e[0m"
  echo -e "\e[38;5;129m${0} 192.168.2.0\e[0m"
}


# Función para indicar que no se ha pasado ningún argumento
function no_arg() {
  echo -e "\e[38;5;196mEste script necesita una dirección IP pasada mediante argumento:\e[0m"
  echo -e "\e[38;5;129m${0} <ip>\e[0m" && echo ""
  echo -e "\e[38;5;162mPuede consultar la ayuda mediante\e[0m" 
  echo -e "\e[38;5;129m${0} -h\e[0m"
  echo -e "\e[38;5;129m${0} --help\e[0m"
  exit 1
}


# Función para mostrar que hay un error en la sintáxis de la IP pasada por argumento
function error_arg() {
  echo -e "\e[38;5;196mEste script necesita una dirección IP con una sintáxis correcta pasada mediante argumento:\e[0m"
  echo -e "\e[38;5;129m${0} 192.168.1.10\e[0m" && echo ""
  echo -e "\e[38;5;162mPuede consultar la ayuda mediante\e[0m" 
  echo -e "\e[38;5;129m${0} -h\e[0m"
  echo -e "\e[38;5;129m${0} --help\e[0m"
  exit 1
}