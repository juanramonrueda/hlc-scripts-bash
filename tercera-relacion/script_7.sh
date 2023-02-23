#!/bin/bash


#-----------------------------------------------------------------------------------
# Declaración de función

# Declaración de la función principal
function main() {
  # Llamada al script que contiene la función para limpiar la pantalla
  source modules/clear_screen.sh
  
  # Se obtiene el formato de hora, minutos y segundos sin delimitadores en variable
  HORA=$(date +%H%M%S)

  # Si la hora se encuentra entre las 06:00:00 y las 12:59:59
  if (( ${HORA} >= 060000 && ${HORA} < 130000 )); then
    echo "Buenos días" 

  # Si la hora se encuentra entre las 13:00:00 y las 19:59:59
  elif (( ${HORA} >= 130000 && ${HORA} < 200000 )) ; then
    echo "Buenas tardes"
  
  # En el resto de los casos
  else
    echo "Buenas noches"
  fi
}


#-----------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi