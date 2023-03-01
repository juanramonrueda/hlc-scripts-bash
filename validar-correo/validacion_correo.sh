#!/bin/bash


#---------------------------
# Declaración de variables

# Se convierte el primer argumento a variable
CORREO_A_VALIDAR="${1}"

# Patrón que valida el correo electrónico
PATRON_CORREO="^[a-zA-Z0-9._-]{1,64}@[a-zA-Z0-9.-]{4,255}\.[a-z]{2,4}$"


#-----------------------------------
# Declaración de funciones

# Función principal
function main() {
  # Llamada al script que contiene la función de limpieza de pantalla
  source modules/clear_screen.sh

  # Comprobación de la cantidad de argumentos pasados al script
  if (( ${#} != 1 )); then
    # En el caso de que sean distintos de 1, ejecutará el script "ayuda"
    source modules/help.sh
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
}


#-----------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi