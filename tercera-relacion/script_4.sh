#!/bin/bash


#------------------------------------------------------------------------------------
# Declaración de variables

# Conversión del primer argumento recibido 
export PRIMER_ARGUMENTO="${1}"


#------------------------------------------------------------------------------------
# Declaración de funciones

# Función para realizar el formateo CSV del directorio actual al fichero pasado 
function ls_csv() {
  # Se lista el contenido en una única columna ls -1
  # Mediante pipeline se pasa a awk para formatear la salida en una única fila
  # mediante printf("%s:") y se pone ":" junto a %s para separar mediante semicolon
  # y después se pasa al fichero dado
  ls -1 | sort | awk '{printf("%s:", $0)}' >> ${PRIMER_ARGUMENTO}
}


# Función principal
function main() {
  # Importación de los módulos necesarios para el script
  source modules/script_4/help.sh

  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función para explicar el funcionamiento del script
      ayuda
    
    else
      # Llamada a la función para realizar el CSV al fichero pasado
      ls_csv
    fi
  
  else
    # Llamada a la función que indica que no se han pasado argumentos al script
    no_arg
  fi
}


#------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi