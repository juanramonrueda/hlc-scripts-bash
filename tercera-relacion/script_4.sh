#!/bin/bash


#-------------------------------------------------------------------
# Declaración de variables

# Conversión del primer argumento recibido 
export PRIMER_ARGUMENTO="$1"


#-------------------------------------------------------------------
# Declaración de funciones

function how_works_script() {
  echo "Para hacer uso del script, debe pasar un único argumento como:" && echo ""
  echo "./script_4.sh prueba.txt" && echo ""
  echo -e "./script_4.sh /home/usuario/prueba.txt\e[0m"
}

# Función principal
function main() {
  if [[ $# == 1 ]]; then
  # Se lista el contenido en una única columna ls -1
  # Mediante pipeline se pasa a awk para formatear la salida
  # en una única fila printf("%s:") y se pone ":" junto a %s
  # para separar mediante colon, después se pasa al fichero dado
  ls -1 | sort | awk '{printf("%s:", $0)}' > $PRIMER_ARGUMENTO
  else
    echo -e "\e[1;31mNúmero de argumentos equivocados"
    how_works_script
  fi
}


#-------------------------------------------------------------------
# Ejecución de la función

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi