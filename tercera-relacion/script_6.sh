#!/bin/bash


#---------------------------------------------------------------------------------
# Declaración de función

# Declaración de la función principal
function main() {
  # Llamada al script que contiene la función para limpiar la pantalla
  source modules/clear_screen.sh

  # Entrada a bucle infinito sin condición
  while true
  do
    # Petición de una pulsación de teclado
    read -n 1 -p 'Pulse una tecla y si quiere salir pulse en Intro... ' TECLA

    # Comprobación si la tecla pulsada es una letra
    if [[ ${TECLA} =~ [[:alpha:]] ]]; then
      echo "" && echo "La tecla ingresada es una letra"
    
    # Comprobación si la tecla pulsada es un número
    elif [[ ${TECLA} =~ [[:digit:]] ]]; then
      echo "" && echo "La tecla ingresada es un número"
    
    # Comprobación si la tecla pulsada es un símbolo
    elif [[ ${TECLA} =~ [[:punct:]] ]]; then
      echo "" && echo "La tecla ingresada es un símbolo"
    
    # Si no es una letra, un número o un símbolo, entonces sale de la ejecución
    else
      # Salida del bucle infinito
      break

      # Devuelve el código 0 para indicar ejecución correcta
      exit 0
    fi
  done
}


#---------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi