#!/bin/bash


#------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Se pasa el primer argumento dado a variable
FICHERO_1="$1"

# Variable para crear otro fichero
FICHERO_1_1="$1_1"

# Se pasa el segundo argumento dado a variable
FICHERO_2="$2"

# Variable para crear otro fichero
FICHERO_2_1="$2_1"

# Se pasa el tercer argumento dado a variable
FICHERO_COMPARACION="$3"


#------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función principal
function main() {
  # Llamada al script para limpiar la pantalla
  source clear_screen.sh

  if [[ $# != 3 ]]; then
    # Llamada a la función que explica cómo funciana el script
    source how_works_script_3.sh

  else
    # Se pasa el contenido del fichero a otro junto con las líneas numeradas
    awk '{print NR, $0}' $FICHERO_1 > $FICHERO_1_1

    # Se pasa el contenido del fichero a otro junto con las líneas numeradas
    awk '{print NR, $0}' $FICHERO_2 > $FICHERO_2_1

    # Se realiza la comprobación de las diferencias de los ficheros en el tercer fichero
    diff --suppress-common-lines $FICHERO_1_1 $FICHERO_2_1 | tee -a $FICHERO_COMPARACION

    # Borrado de los archivos intermedios para la numeración de las líneas
    rm $FICHERO_1_1 && rm $FICHERO_2_1
  fi
}


#------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi