#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variable

# Se convierte el primer argumento en variable
export RUTA_DIRECTORIOS="${1}"

# Se inicializa la variable para el loop "while read line", se inicializa a 1 por tema del script
export INCREMENTO=1

# Inicialización de la variable a "1" para entrar al bucle de petición de elemento del array
export ELEMENTO_ARRAY=1


#---------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para almacenar en array los elementos de un directorio pasado por argumento
function create_array() {
  # Se usa este bucle para recorrer el directorio que el usuario ha indicado
  while read line
  do
    # Se guarda en array el directorio que está en ese momento en el loop while
    ARRAY[${INCREMENTO}]="${line}"

    # Se incrementa la variable que indica la posición de cada elemento en el bucle
    (( INCREMENTO++ ))
  
  # Se para el comando ls a la variable que ha pasado el usuario para el loop while read line
  done < <(ls ${RUTA_DIRECTORIOS})
  
  # Se obtienen todos los elementos que contiene el array establecido
  CANTIDAD_ELEMENTOS_ARRAY=$( echo ${ARRAY[@]} | wc -w )
}


# Función para recorrer el array y mostrar los elementos
function recorrer_array() {
  # Mientras el número introducido por el usuario sea distinto de 0, el bucle continuará
  while (( ${ELEMENTO_ARRAY} != 0 )); do
    # Petición de un número para el array
    read -p "Introduzca un número del 1 al ${CANTIDAD_ELEMENTOS_ARRAY} para conocer la posición de un elemento o pulse el 0 para salir: " ELEMENTO_ARRAY

    # Se comprueba que el número sea distinto de 0 para salir inmediatamente de la ejecución del script y no mostrar nada más
    if (( ${ELEMENTO_ARRAY} != 0 )); then
      # Se muestra un mensaje al usuario
      echo "" && echo -e "\e[34mEl elemento que está en la posición ${ELEMENTO_ARRAY} del array es:"
      
      # Se indica el elemento del array que ha pedido el usuario
      echo -e "\e[1m${ARRAY[${ELEMENTO_ARRAY}]}\e[0m" && echo ""
    fi
  done
}


# Función principal
function main() {
  # Importación de los módulos necesarios para el script
  source modules/script_5/help.sh
  
  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función ayuda
      ayuda

    else
      create_array

      recorrer_array
    fi
  else
    no_arg
  fi
}


#---------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi