#!/bin/bash

#-----------------------------------------------------------------------------------------------------
# Declaración de funciones

# Se pasa el contenido del primer argumento a variable
FICHERO_ENTRADA="$1"

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


#-----------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para cambiar el contenido del fichero a minúsculas en otro fichero
function conversion_lower_case() {
  tr $PATRON_MINUSCULAS < $FICHERO_ENTRADA > $FICHERO_SALIDA_MINUSCULAS
}


# Función para cambiar el contenido del fichero a mayúsculas en otro fichero
function conversion_upper_case() {
  tr $PATRON_MAYUSCULAS < $FICHERO_ENTRADA > $FICHERO_SALIDA_MAYUSCULAS
}


# Función para quitar todas las letras "a" del fichero en otro fichero
function no_a() {
  sed "s/a//g" $FICHERO_ENTRADA > $FICHERO_SALIDA_NO_A
}


# Función para pasar todas las vocales a mayúsculas en otro fichero
function vowels_upper_case() {
  tr $PATRON_VOCALES_MAYUSCULAS < $FICHERO_ENTRADA > $FICHERO_SALIDA_VOCALES_MAYUSCULAS
}


# Función principal
function main() {
  # Comprobación de la cantidad de argumentos pasados al script
  if (( $# != 1 )); then
    # Llamada al script que tiene las instrucciones del script
    source how_works_script_1.sh

  # En el caso de que los argumentos sean correctos, se llamará a las funciones anteriores
  else
    # Llamada a la función para la conversión a minúsculas del contenido del fichero de entrada
    conversion_lower_case

    # Llamada a la función para la conversión a mayúsculas del contenido del fichero de entrada
    conversion_upper_case

    # Llamada a la función para eliminar todas las "a" del contenido del fichero de entrada
    no_a

    # Llamada a la función para la conversión a mayúsculas de las vocales del fichero de entrada
    vowels_upper_case
  fi
}


#-----------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi