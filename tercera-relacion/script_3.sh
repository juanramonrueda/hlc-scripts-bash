#!/bin/bash


#------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Se pasa el primer argumento dado a variable
FICHERO_1="$1"

# Se pasa el segundo argumento dado a variable
FICHERO_2="$2"

# Se pasa el tercer argumento dado a variable
FICHERO_COMPARACION="$3"


#------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función que muestra un mensaje en caso de no recibir los argumentos necesarios
function how_works_script() {
  echo "Para hacer uso del script, debe pasar tres ficheros (el tercero no importa si existe) como:" && echo ""
  echo "./script_2.sh fichero_1.txt fichero_2.txt fichero_3.txt" && echo ""
  echo "./script_2.sh /home/usuario/fichero_1.txt /home/usuario/Documentos/fichero_2.txt ./fichero_3.txt"
}
# Función principal
function main() {
  # Llamada al script para limpiar la pantalla
  source clear_screen.sh

  if [[ $# != 3 ]]; then
    echo -e "\e[1;91mNúmero de argumentos incorrecto"
    
    # Llamada a la función que explica cómo funciana el script
    how_works_script
  else
    diff --suppress-common-lines $FICHERO_1 $FICHERO_2 | tee -a $FICHERO_COMPARACION
  fi
}


#------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi