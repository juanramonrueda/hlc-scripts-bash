#!/bin/bash


#---------------------------------------------------------------------------------
# Declaración de función

# Declaración de la función principal
function main() {
  while true
  do
    # Petición de una pulsación de teclado
    read -n 1 -p 'Pulse una tecla y si quiere salir pulse en Intro... ' key

    # Comprobación si la tecla pulsada es una letra
    if [[ $key =~ [[:alpha:]] ]]; then
      echo "La tecla ingresada es una letra"
    
    # Comprobación si la tecla pulsada es un número
    elif [[ $key =~ [[:digit:]] ]]; then
      echo "La tecla ingresada es un número"
    
    # Comprobación si la tecla pulsada es un símbolo
    elif [[ $key =~ [[:punct:]] ]]; then
      echo "La tecla ingresada es un símbolo"
    
    # Si no es una letra, un número o un símbolo, entonces sale de la ejecución
    else
      break
    fi
  done
}


#---------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi