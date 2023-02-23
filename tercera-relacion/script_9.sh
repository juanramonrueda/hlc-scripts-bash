#!/bin/bash

#-----------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Se pasa el contenido del primer argumento a variable
FICHERO_ENTRADA="${1}"

# Nombre del fichero de salida para la conversión a minúsculas del fichero de entrada
FICHERO_SALIDA_MINUSCULAS="./R_minusculas.txt"

# Patrón para cambiar de mayúsculas a minúsculas
PATRON_MINUSCULAS="[A-Z,Ñ,Á,É,Í,Ó,Ú,Ü] [a-z,ñ,á,é,í,ó,ú,ü]"

# Nombre del fichero de salida para la conversión a mayúsculas del fichero de entrada
FICHERO_SALIDA_MAYUSCULAS="./R_mayusculas.txt"

# Patrón para cambiar de minúsculas a mayúsculas
PATRON_MAYUSCULAS="[a-z,ñ,á,é,í,ó,ú,ü] [A-Z,Ñ,Á,É,Í,Ó,Ú,Ü]"

# Nombre del fichero de salida para la eliminación de la vocal "a" del fichero de entrada
FICHERO_SALIDA_NO_A="./R_sinA.txt"

# Nombre del fichero de salida para convertir todas las vocales a mayúsculas del fichero de entrada
FICHERO_SALIDA_VOCALES_MAYUSCULAS="./R_VOCALES.txt"

# Patrón para cambiar las vocales de minúsculas a mayúsculas
PATRON_VOCALES_MAYUSCULAS="[a,e,i,o,u,á,é,í,ó,ú,ü] [A,E,I,O,U,Á,É,Í,Ó,Ú,Ü]"


#-----------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para explicar el comportamiento del script
function ayuda() {
  echo -e "\e[38;5;27mEste script necesita un fichero (con texto a poder ser) para realizar distintas operaciones a otros ficheros"
  echo -e "\e[0m"
}

# Función que explica de forma breve el error del usuario
function error() {
  echo -e "\e[38;5;160mDebe pasar únicamente un fichero y no un directorio como argumento al script\e[0m"

  # Se genera el código de error para indicar que la ejecución no ha sido correcta
  exit 1
}

# Función para cambiar el contenido del fichero a minúsculas en otro fichero
function conversion_lower_case() {
  echo -e "\e[38;5;98mConversión de las letras a minúsculas\e[1m"
  tr ${PATRON_MINUSCULAS} < ${FICHERO_ENTRADA} | tee -a ${FICHERO_SALIDA_MINUSCULAS}
}


# Función para cambiar el contenido del fichero a mayúsculas en otro fichero
function conversion_upper_case() {
  echo -e "\e[0m" && echo -e "\e[38;5;117mConversión de las letras a mayúsculas\e[1m"
  tr ${PATRON_MAYUSCULAS} < ${FICHERO_ENTRADA} | tee -a ${FICHERO_SALIDA_MAYUSCULAS}
}


# Función para quitar todas las letras "a" del fichero en otro fichero
function no_a() {
  echo -e "\e[0m" && echo -e "\e[38;5;202mSupresión de la letra 'a'\e[1m"
  sed "s/[aA]//g" ${FICHERO_ENTRADA} | tee -a ${FICHERO_SALIDA_NO_A}
}


# Función para pasar todas las vocales a mayúsculas en otro fichero
function vowels_upper_case() {
  echo -e "\e[0m" && echo -e "\e[38;5;208mConversión de todas las vocales a mayúsculas\e[1m"
  tr ${PATRON_VOCALES_MAYUSCULAS} < ${FICHERO_ENTRADA} | tee -a ${FICHERO_SALIDA_VOCALES_MAYUSCULAS}
}


# Función principal
function main() {
  # Llamada al script que contiene la función para limpiar la pantalla
  source modules/clear_screen.sh

  # Comprobación de la cantidad de argumentos pasados al script
  if (( $# != 1 )); then
    # Llamada a la función que sirve de ayuda
    ayuda 

    # Llamada al script que tiene las instrucciones del script
    source modules/how_works_script_1.sh

  # En el caso de que los argumentos sean correctos, se llamará a las funciones anteriores
  else
    if test -f ${FICHERO_ENTRADA}; then
      # Llamada a la función para la conversión a minúsculas del contenido del fichero de entrada
      conversion_lower_case

      # Llamada a la función para la conversión a mayúsculas del contenido del fichero de entrada
      conversion_upper_case

      # Llamada a la función para eliminar todas las "a" del contenido del fichero de entrada
      no_a

      # Llamada a la función para la conversión a mayúsculas de las vocales del fichero de entrada
      vowels_upper_case
    else
      error
    fi
  fi
}


#-----------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi