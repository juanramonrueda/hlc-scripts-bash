#!/bin/bash


#----------------------------------------------------------------------------------------
# Declaración de funciones

# Función que contiene el flujo normal del programa
function normal_execution() {
  # Se obtiene el formato de hora, minutos y segundos sin delimitadores en variable
  HORA=$(date +%H%M%S)

  # Si la hora se encuentra entre las 06:00:00 y las 12:59:59
  if (( ${HORA} >= 060000 && ${HORA} < 130000 )); then
    echo -e "\e[38;5;14mBuenos días\e[0m" 

  # Si la hora se encuentra entre las 13:00:00 y las 19:59:59
  elif (( ${HORA} >= 130000 && ${HORA} < 200000 )) ; then
    echo -e "\e[38;5;202mBuenas tardes\e[0m"
  
  # En el resto de los casos
  else
    echo -e "\e[38;5;91mBuenas noches\e[0m"
  fi
}

# Declaración de la función principal
function main() {
  # Importación de módulos necesarios para el script
  source modules/script_7/help.sh
  
  if (( ${#} == 0 )); then
    # Llamada a la función que tiene el flujo normal del programa
    normal_execution
  
  elif (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que muestra la ayuda del programa
      ayuda
    
    else
      # Llamada a la función que indica que hay un error en la petición de la ayuda
      error_ayuda
    fi

  else
    # Llamada a la función que indica que no se necesitan argumentos para la ejecución
    no_args
  fi
}


#----------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi