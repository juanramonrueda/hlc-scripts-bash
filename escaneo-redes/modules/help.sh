#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función principal para indicar cómo funciona el script
function main() {
  echo -e "\e[38;5;198mPara usar correctamente el script, tiene que pasar una dirección de red o una IP completa:"
  echo "" && echo -e "\e[1m${0} 192.168.1.0" && echo "" && echo -e "${0} 192.168.1.22\e[0m"

  exit 1
}


#-------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

main