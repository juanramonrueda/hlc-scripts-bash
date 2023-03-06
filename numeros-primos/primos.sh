#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Conversión del primer argumento a variable
export PRIMER_NUMERO="${1}"

# Conversión del segundo argumento a variable
export SEGUNDO_NUMERO="${2}"

# Patrón para verificar si los números introducidos son enteros positivos
PATRON_INT="^[0-9]+$"


#-------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función que muestra los números primos entre los argumentos pasados al script
function mostrar_primos() {
  # Bucle que recorre desde el primer número hasta el segundo
  for i in $(seq ${PRIMER_NUMERO} ${SEGUNDO_NUMERO})
  do
    # Inicialización de la varaible contadora a 0 tras cada bucle para "limpiar" y evitar errores
    CONTADOR_DIVISORES=0

    # Bucle para recorrer desde el número 1 hasta el número que hay en el primer bucle
    for j in $(seq 1 ${i})
    do
      # En el caso de que el módulo del número del primer bucle entre el del segundo bucle sea 0, es divisor e incrementa la variable contadora
      if (( $i % $j == 0 )); then
        # Incremento de la variable contadora
        CONTADOR_DIVISORES=$(($CONTADOR_DIVISORES + 1)) 
      fi
    done
    # En el caso de que el número tenga únicamente dos divisores, es un número primo y por tanto se muestra
    if (( ${CONTADOR_DIVISORES} == 2 )); then
      echo -e "\e[38;5;105mNúmero primo entre ${PRIMER_NUMERO} y ${SEGUNDO_NUMERO} ---> \e[1m${i}\e[0m"
    fi
  done
}


# Función para intercambiar variables en el caso de que el primer argumento sea mayor que el segundo usando una variable auxiliar
function intercambiar_variables() {
  AUX=${PRIMER_NUMERO}
  PRIMER_NUMERO=${SEGUNDO_NUMERO}
  SEGUNDO_NUMERO=${AUX}
}


# Función para comprobar el valor de los argumentos pasados
function comprobar_numeros() {
  # Comprobación mediante patrón de los argumentos pasados por el usuario
  if [[ ${PRIMER_NUMERO} =~ ${PATRON_INT} ]]; then
    
    if [[ ${SEGUNDO_NUMERO} =~ ${PATRON_INT} ]]; then
      # Comprobación de cuál de los números pasados es menor y cuál es mayor
      if (( ${PRIMER_NUMERO} > ${SEGUNDO_NUMERO} )); then
        # En el caso de que la primera variable sea mayor que la seguna, se llamará a la función que las intercambia
        intercambiar_variables
      fi

      # Llamada a la función que muestra los números primos entre los dos argumentos pasados por el usuario
      mostrar_primos

    else
      echo -e "\e[38;5;1mEl segundo número, \"${SEGUNDO_NUMERO}\", no ha pasado el patrón\e[0m"

      # Llamada a la función para indicar que se deben pasar únicamente números enteros positivos
      no_numbers
    fi
  else
    echo -e "\e[38;5;1mEl primer número, \"${PRIMER_NUMERO}\", no ha pasado el patrón requerido\e[0m"
    
    # Llamada a la función para indicar que se deben pasar únicamente números enteros positivos
    no_numbers
  fi
}


# Función principal
function main() {
  # Importación de los módulos necesarios para el script
  source modules/help.sh

  # Comprobación de la cantidad de argumentos pasados al script
  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que explica el script y su uso
      ayuda

    else
      # Llamada a la función que indica que hay un error en la petición de ayuda
      error_ayuda
    fi
  elif (( ${#} == 2 )); then
    # Llamada a la función que comprueba los argumentos pasados por el usuario
    comprobar_numeros
  
  else
    # Llamada a la función que indica que no se han pasado los argumentos requeridos
    no_args
  fi
}


#-------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi