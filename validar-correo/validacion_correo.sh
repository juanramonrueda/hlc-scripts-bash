#!/bin/bash


#---------------------------
# Declaración de variables

# Se convierte el primer argumento a variable
CORREO_A_VALIDAR="${1}"

# Patrón que valida el correo electrónico, permite uso de string, integer, dot, dash y hyphen
PATRON_CORREO="^[a-zA-Z0-9._-]{1,64}@[a-zA-Z0-9.-]{4,255}\.[a-z]{2,4}$"


#-----------------------------------
# Declaración de funciones

# Función principal
function main() {
  # Importación del módulo que contiene la ayuda con respecto al script
  source modules/help.sh

  # Comprobación de la cantidad de argumentos pasados al script
  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que explica el funcionamiento del script
      ayuda
    
    else
      # Comprobación del correo pasado con el patrón definido al principio
      if [[ ${CORREO_A_VALIDAR} =~ ${PATRON_CORREO} ]]; then
        echo -e "\e[1;38;5;46mEl correo electrónico ${CORREO_A_VALIDAR} es un correo válido"
      else
        echo -e "\e[1;38;5;196mEl correo electrónico ${CORREO_A_VALIDAR} no es un correo válido"

        # Salida no exitosa al no pasar la validación
        exit 1
      fi
    fi

  else
    # Llamada al script para indicar que no se ha pasado la cantidad de argumentos requerida
    error_arg
  fi
}


#-----------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi