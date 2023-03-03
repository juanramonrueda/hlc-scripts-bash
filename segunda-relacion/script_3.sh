#!/bin/bash


#--------------------------------------------------------------------------------------------
# Declaración de variables

# Conversión del primer argumento a variable
PRIMERA_VARIABLE="${1}"

# Conversión del segundo arguemento a variable
SEGUNDA_VARIABLE="${2}"

# Concatenación de la primera variable junto a la segunda variable para la ruta del archivo
RUTA_ARCHIVO="${OPCN_USUARIO}/${SEGUNDA_VARIABLE}"


#--------------------------------------------------------------------------------------------
# Declaración de función

# Función principal
function main() {
  # Importación de módulos para este script
  source modules/script_3/help.sh

  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que muestra la ayuda del script help.sh
      ayuda
      
    else
      # Llamada a la función que muestra el error en cuanto a la petición de ayuda 
      error_ayuda
    fi

  elif (( ${#} == 2 )); then
    # Comprobación de que la primera variable (primer argumento) dado existe
    if test -d ${OPCN_USUARIO}; then
      # Comprobación de que la concatenación de la ruta del archivo es un fichero
      if test -f ${RUTA_ARCHIVO}; then
        # Petición al usuario de ver el contenido del fichero
        read -n 1 -p '¿Quiere ver el contenido del fichero? (s/n)... ' VER_CONTENIDO

        # Comprobación para saber si el usuario quiere ver el contenido del fichero
        if [[ ${VER_CONTENIDO} == "S" || ${VER_CONTENIDO} == "s" ]]; then
          echo "" && cat ${RUTA_ARCHIVO}
        fi
      
      # En caso de se otro tipo de archivo, como un directorio, mostrará un mensaje
      else
        echo "El segundo argumento, ${SEGUNDA_VARIABLE} no es un fichero"
        exit 1
      fi
    
    # Mensaje para indicar que el primer argumento tiene un error o es un fichero
    else
      echo "El primer argumento, ${OPCN_USUARIO} no es un directorio o tiene un error"
      exit 1
    fi

  else
    no_arg
  fi
}


#--------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi