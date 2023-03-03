#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función principal para indicar cómo funciona el script
function ayuda() {
  echo -e "\e[38;5;162mEste script tiene la función de comprobar los hosts activos en la red"
  echo -e "Para usar el script, tiene que pasar una dirección de red o una IP de host\e[0m"
  echo "" && echo -e "\e[38;5;129m${0} 192.168.1.0" && echo -e "${0} 192.168.1.10\e[0m"
}