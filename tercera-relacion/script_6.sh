#!/bin/bash


#--------------------------------------------------------------------------------------------
# Declaración de funciones

# Función que contiene el flujo loop del programa
function loop_execution() {
  # Entrada a bucle infinito
  while true
  do
    # Petición de una pulsación de teclado
    read -n 1 -p 'Pulse una tecla y si quiere salir pulse en Intro... ' TECLA

    # Comprobación si la tecla pulsada es una letra
    if [[ ${TECLA} =~ [[:alpha:]] ]]; then
      echo "" && echo -e "\e[38;5;104mLa tecla ingresada es una letra\e[0m"
    
    # Comprobación si la tecla pulsada es un número
    elif [[ ${TECLA} =~ [[:digit:]] ]]; then
      echo "" && echo -e "\e[38;5;155mLa tecla ingresada es un número\e[0m"
    
    # Comprobación si la tecla pulsada es un símbolo
    elif [[ ${TECLA} =~ [[:punct:]] ]]; then
      echo "" && echo -e "\e[38;5;89mLa tecla ingresada es un símbolo\e[0m"
    
    # Si no es una letra, un número o un símbolo, entonces sale de la ejecución
    else

      # Sale del bucle infinito y devuelve el código 0 para indicar una ejecución correcta
      exit 0
    fi
  done
}


# Declaración de la función principal
function main() {
  # Importación de módulos necesarios para el script
  source modules/script_6/help.sh

  if (( ${#} == 0 )); then
    # Llamada a la función que contiene flujo loop del programa
    loop_execution

  elif (( ${#} == 1 ));then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      ayuda

    else
      error_ayuda
    fi
  
  else
    no_args
  fi
}


#--------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi